import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraWidgetState {
  final CameraController? controller;
  final bool isInitialized;
  final bool isInitializing;
  final bool permissionDenied;
  final bool permissionPermanentlyDenied;
  final String? error;
  final Uint8List? imageBytes;

  CameraWidgetState({
    this.controller,
    this.isInitialized = false,
    this.isInitializing = false,
    this.permissionDenied = false,
    this.permissionPermanentlyDenied = false,
    this.error,
    this.imageBytes,
  });
}

class CameraWidgetController extends Notifier<CameraWidgetState> {
  CameraController? _cameraController;

  @override
  CameraWidgetState build() {
    // When the provider is disposed, dispose the local controller reference
    // without reading 'state' (which violates Riverpod lifecycle rules).
    ref.onDispose(() {
      final controller = _cameraController;
      _cameraController = null;
      unawaited(_disposeCameraController(controller));
    });
    return CameraWidgetState();
  }

  Future<void> initializeCamera() async {
    if (state.isInitialized || state.isInitializing) return;
    state = CameraWidgetState(isInitializing: true);

    try {
      final previousController = _cameraController;
      _cameraController = null;
      await _disposeCameraController(previousController);

      var permission = await Permission.camera.status;
      if (!permission.isGranted && !permission.isPermanentlyDenied) {
        permission = await Permission.camera.request();
      }
      if (!ref.mounted) return;

      if (!permission.isGranted) {
        final permanentlyDenied = await _isPermissionBlocked(permission);
        if (!ref.mounted) return;
        state = CameraWidgetState(
          permissionDenied: true,
          permissionPermanentlyDenied: permanentlyDenied,
        );
        return;
      }

      final cameras = await availableCameras();
      if (!ref.mounted) return;
      if (cameras.isEmpty) {
        state = CameraWidgetState(
          error: 'Camera is not available on this device.',
        );
        return;
      }

      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      if (!ref.mounted) {
        await _disposeCameraController(_cameraController);
        _cameraController = null;
        return;
      }

      state = CameraWidgetState(
        controller: _cameraController,
        isInitialized: true,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Camera Init Error: $e');
      final failedController = _cameraController;
      _cameraController = null;
      await _disposeCameraController(failedController);
      if (!ref.mounted) return;

      if (e is CameraException &&
          (e.code.startsWith('CameraAccessDenied') ||
              e.code == 'CameraAccessRestricted')) {
        final permission = await Permission.camera.status;
        if (!ref.mounted) return;
        final permanentlyDenied = await _isPermissionBlocked(permission);
        if (!ref.mounted) return;
        state = CameraWidgetState(
          permissionDenied: true,
          permissionPermanentlyDenied: permanentlyDenied,
        );
      } else {
        state = CameraWidgetState(
          error: 'Camera failed to start. Please try again.',
        );
      }
    }
  }

  Future<bool> _isPermissionBlocked(PermissionStatus permission) async {
    if (permission.isPermanentlyDenied || permission.isRestricted) return true;
    if (permission.isDenied &&
        defaultTargetPlatform == TargetPlatform.android) {
      return !(await Permission.camera.shouldShowRequestRationale);
    }
    return false;
  }

  Future<void> _disposeCameraController(CameraController? controller) async {
    if (controller == null) return;
    try {
      await controller.dispose();
    } catch (error) {
      if (kDebugMode) debugPrint('Camera dispose error: $error');
    }
  }

  void setImageBytes(Uint8List bytes) {
    state = CameraWidgetState(
      controller: _cameraController,
      isInitialized: true,
      imageBytes: bytes,
    );
  }

  void clearImage() {
    state = CameraWidgetState(
      controller: _cameraController,
      isInitialized: state.isInitialized,
    );
  }
}

final cameraWidgetProvider =
    NotifierProvider.autoDispose<CameraWidgetController, CameraWidgetState>(
      CameraWidgetController.new,
    );
