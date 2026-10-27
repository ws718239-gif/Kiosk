import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/responsive/app_constraints.dart';
import '../../../../core/i18n/app_strings.dart';
import '../../../visitor_checkin/domain/models/visitor_model.dart';

class VisitorBadgeScreen extends StatelessWidget {
  final VisitorModel visitor;
  const VisitorBadgeScreen({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    final qrData = _qrData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Badge'.tr(context)),
        automaticallyImplyLeading: false, // Prevent going back to form
      ),
      body: Center(
        child: qrData == null
            ? _buildMissingBadge(context)
            : ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppConstraints.maxFormWidth,
                ),
                child: Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: 16.w,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: _buildBadge(context, qrData),
                ),
              ),
      ),
    );
  }

  String? get _qrData {
    final badgeCode = visitor.badgeCode?.trim();
    if (badgeCode != null && badgeCode.isNotEmpty) {
      return 'kiosk_checkin:$badgeCode';
    }

    final id = visitor.id?.trim();
    if (id != null && id.isNotEmpty) return 'kiosk_checkin:$id';
    return null;
  }

  Widget _buildMissingBadge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.orange, size: 56),
          const SizedBox(height: 16),
          Text(
            'Badge identifier unavailable. Please contact reception.'.tr(
              context,
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: Text('Return to Home'.tr(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String qrData) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content tightly
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 64),
          const SizedBox(height: 16),
          Text(
            'Check-in Successful!'.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 32),
          Text(
            visitor.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Visitor'.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // QR Code rendering
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
          ),

          const SizedBox(height: 16),
          Text(
            'Please scan this badge at the exit.'.tr(context),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Return to dashboard
                context.go('/');
              },
              child: Text(
                'Return to Home'.tr(context),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
