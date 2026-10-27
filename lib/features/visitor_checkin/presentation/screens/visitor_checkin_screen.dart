import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/responsive/app_constraints.dart';
import '../../../../core/i18n/app_strings.dart';
import '../../../host_directory/domain/models/host_model.dart';
import '../../domain/models/visitor_model.dart';
import '../controllers/checkin_controller.dart';
import '../controllers/form_state_controller.dart';
import 'camera_capture_widget.dart';

class VisitorCheckInScreen extends ConsumerStatefulWidget {
  final HostModel host;
  const VisitorCheckInScreen({super.key, required this.host});

  @override
  ConsumerState<VisitorCheckInScreen> createState() =>
      _VisitorCheckInScreenState();
}

class _VisitorCheckInScreenState extends ConsumerState<VisitorCheckInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Widget _buildFieldError(BuildContext context, String errorText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(errorText, textAlign: TextAlign.left),
    );
  }

  // Allowed purposes by Mock API server.js
  String _selectedPurpose = 'meeting';
  final List<Map<String, String>> _purposes = [
    {'id': 'meeting', 'label': 'Meeting'},
    {'id': 'interview', 'label': 'Interview'},
    {'id': 'delivery', 'label': 'Delivery'},
    {'id': 'vendor', 'label': 'Vendor / Contractor'},
    {'id': 'maintenance', 'label': 'Maintenance'},
    {'id': 'personal', 'label': 'Personal'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm(VisitorFormState formState) {
    if (_formKey.currentState!.validate()) {
      if (!formState.consentGiven) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please accept the consent terms.'.tr(context)),
          ),
        );
        return;
      }
      if (formState.photoBase64 == null || formState.photoBase64!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please take a photo.'.tr(context))),
        );
        return;
      }

      final visitor = VisitorModel(
        hostId: widget.host.id,
        hostName: widget.host.name,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _phoneController.text.trim(),
        purpose: _selectedPurpose,
        photo: formState.photoBase64,
        consent: formState.consentGiven,
      );

      ref.read(checkInControllerProvider.notifier).submitForm(visitor);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for state changes to navigate on success
    ref.listen<CheckInState>(checkInControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!.tr(context)),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next.successData != null) {
        // Navigate to Badge screen
        context.pushReplacement('/badge', extra: next.successData);
      }
    });

    final checkInState = ref.watch(checkInControllerProvider);
    final formState = ref.watch(visitorFormProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Visitor Check-in'.tr(context))),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstraints.maxFormWidth,
          ),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: _buildForm(context, checkInState, formState),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    CheckInState checkInState,
    VisitorFormState formState,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(32.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Selected Host Info
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person, size: 40),
              title: Text(
                'Meeting with: {host}'.tr(context, {'host': widget.host.name}),
              ),
              subtitle: Text(widget.host.department),
            ),
            const Divider(height: 32),

            // Camera Widget
            Center(
              child: CameraCaptureWidget(
                onPhotoCaptured: (base64Image) {
                  ref.read(visitorFormProvider.notifier).setPhoto(base64Image);
                },
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
            TextFormField(
              controller: _nameController,
              textAlign: TextAlign.left,
              errorBuilder: _buildFieldError,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Full Name'.tr(context),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(),
                counterText: '',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter your name'.tr(context);
                }
                if (v.trim().length < 2) {
                  return 'Name is too short'.tr(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              textAlign: TextAlign.left,
              errorBuilder: _buildFieldError,
              keyboardType: TextInputType.emailAddress,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: 'Email Address'.tr(context),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(),
                counterText: '',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter email'.tr(context);
                }
                final emailRegex = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                );
                if (!emailRegex.hasMatch(v.trim())) {
                  return 'Please enter a valid email'.tr(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              textAlign: TextAlign.left,
              errorBuilder: _buildFieldError,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: 'Mobile Number (10 digits)'.tr(context),
                hintText: 'e.g. 9876543210'.tr(context),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(),
                counterText: '',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter mobile number'.tr(context);
                }
                // Mock API server.js strictly requires 10 digits starting with 6-9
                final phoneRegex = RegExp(r'^[6-9]\d{9}$');
                if (!phoneRegex.hasMatch(v.trim())) {
                  return 'Enter a valid 10-digit Indian mobile number (starts with 6-9)'
                      .tr(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Purpose Dropdown (Strictly matches Mock API server.js allowed purposes)
            DropdownButtonFormField<String>(
              initialValue: _selectedPurpose,
              decoration: InputDecoration(
                labelText: 'Purpose of Visit'.tr(context),
                border: OutlineInputBorder(),
              ),
              items: _purposes.map((p) {
                return DropdownMenuItem<String>(
                  value: p['id'],
                  child: Text(p['label']!.tr(context)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedPurpose = val;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // Consent Checkbox
            CheckboxListTile(
              title: Text(
                'I agree to the non-disclosure agreement and security policies of Naapbooks Limited.'
                    .tr(context),
              ),
              value: formState.consentGiven,
              onChanged: (val) {
                ref
                    .read(visitorFormProvider.notifier)
                    .toggleConsent(val ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: checkInState.isLoading
                    ? null
                    : () => _submitForm(formState),
                child: checkInState.isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Submit & Check-in'.tr(context),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
