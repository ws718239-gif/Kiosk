import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisitorFormState {
  final String? photoBase64;
  final bool consentGiven;

  VisitorFormState({this.photoBase64, this.consentGiven = false});

  VisitorFormState copyWith({String? photoBase64, bool? consentGiven}) {
    return VisitorFormState(
      photoBase64: photoBase64 ?? this.photoBase64,
      // If we pass null to photoBase64 explicitly, we want to clear it
      // but copyWith usually doesn't allow setting to null cleanly without a special pattern.
      // For this app, an empty string will represent cleared photo.
      consentGiven: consentGiven ?? this.consentGiven,
    );
  }
}

class VisitorFormController extends Notifier<VisitorFormState> {
  @override
  VisitorFormState build() => VisitorFormState();

  void setPhoto(String base64Image) {
    state = state.copyWith(photoBase64: base64Image);
  }

  void clearPhoto() {
    state = VisitorFormState(consentGiven: state.consentGiven);
  }

  void toggleConsent(bool value) {
    state = state.copyWith(consentGiven: value);
  }
}

final visitorFormProvider =
    NotifierProvider.autoDispose<VisitorFormController, VisitorFormState>(
      VisitorFormController.new,
    );
