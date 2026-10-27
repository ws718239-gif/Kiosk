import 'dart:convert';

import 'package:image/image.dart' as img;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/camera_controller_provider.dart';
import '../../../../core/i18n/app_strings.dart';

// Top-level function for background isolate image compression
Uint8List _compressImage(Uint8List bytes) {
  final image = img.decodeImage(bytes);
  if (image == null) return bytes;

  // Resize to a max width of 400px to save memory and network bandwidth
  final resized = img.copyResize(image, width: 400);
  return Uint8List.fromList(img.encodeJpg(resized, quality: 75));
}

class CameraCaptureWidget extends ConsumerStatefulWidget {
  final Function(String base64Image) onPhotoCaptured;

  const CameraCaptureWidget({super.key, required this.onPhotoCaptured});

  @override
  ConsumerState<CameraCaptureWidget> createState() =>
      _CameraCaptureWidgetState();
}

class _CameraCaptureWidgetState extends ConsumerState<CameraCaptureWidget>
    with WidgetsBindingObserver {
  bool _openedSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Schedule camera initialization after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraWidgetProvider.notifier).initializeCamera();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed || !mounted) return;

    final cameraState = ref.read(cameraWidgetProvider);
    if (!cameraState.permissionDenied && !_openedSettings) return;

    Permission.camera.status.then((permission) {
      if (mounted && permission.isGranted) {
        _openedSettings = false;
        ref.read(cameraWidgetProvider.notifier).initializeCamera();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _takePhoto(CameraWidgetState cameraState) async {
    final controller = cameraState.controller;
    if (controller == null || !controller.value.isInitialized) return;

    try {
      final XFile photo = await controller.takePicture();
      final bytes = await photo.readAsBytes();

      // Optimize: Compress image on a background isolate to prevent UI jank
      final compressedBytes = await compute(_compressImage, bytes);
      final base64Raw = base64Encode(compressedBytes);
      // Format as Data URL required by Mock API server.js
      final base64String = 'data:image/jpeg;base64,$base64Raw';

      if (!mounted) return;

      // Use Riverpod to update state instead of setState
      ref.read(cameraWidgetProvider.notifier).setImageBytes(compressedBytes);
      widget.onPhotoCaptured(base64String);
    } catch (e) {
      if (kDebugMode) debugPrint('Take Photo Error: $e');
    }
  }

  void _retakePhoto() {
    // Use Riverpod to clear state instead of setState
    ref.read(cameraWidgetProvider.notifier).clearImage();
    widget.onPhotoCaptured('');
  }

  @override
  Widget build(BuildContext context) {
    // Watch the camera state from Riverpod
    final cameraState = ref.watch(cameraWidgetProvider);

    if (cameraState.imageBytes != null) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              cameraState.imageBytes!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          TextButton.icon(
            onPressed: _retakePhoto,
            icon: const Icon(Icons.refresh),
            label: Text('Retake Photo'.tr(context)),
          ),
        ],
      );
    }

    if (cameraState.permissionDenied || cameraState.error != null) {
      final permanentlyDenied = cameraState.permissionPermanentlyDenied;
      final message = cameraState.permissionDenied
          ? (permanentlyDenied
                ? 'Camera access is blocked. Open app settings to allow camera access.'
                : 'Camera access was denied. Please allow camera permission to take a visitor photo.')
          : cameraState.error!;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.camera_alt_outlined, size: 48),
          const SizedBox(height: 8),
          Text(message.tr(context), textAlign: TextAlign.center),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  _openedSettings = true;
                  await openAppSettings();
                },
                icon: const Icon(Icons.settings),
                label: Text('Open Settings'.tr(context)),
              ),
            ],
          ),
        ],
      );
    }

    if (!cameraState.isInitialized || cameraState.controller == null) {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 150,
            height: 150,
            child: CameraPreview(cameraState.controller!),
          ),
        ),
        TextButton.icon(
          onPressed: () => _takePhoto(cameraState),
          icon: const Icon(Icons.camera_alt),
          label: Text('Take Photo'.tr(context)),
        ),
      ],
    );
  }
}
