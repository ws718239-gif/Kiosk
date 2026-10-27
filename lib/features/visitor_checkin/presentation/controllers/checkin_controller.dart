import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/checkin_repository.dart';
import '../../domain/models/visitor_model.dart';

class CheckInState {
  final bool isLoading;
  final String? error;
  final VisitorModel? successData;

  CheckInState({this.isLoading = false, this.error, this.successData});

  CheckInState copyWith({
    bool? isLoading,
    String? error,
    VisitorModel? successData,
  }) {
    return CheckInState(
      isLoading: isLoading ?? this.isLoading,
      error: error, // Can be null, intentional to reset error
      successData: successData ?? this.successData,
    );
  }
}

class CheckInController extends Notifier<CheckInState> {
  @override
  CheckInState build() => CheckInState();

  Future<void> submitForm(VisitorModel visitor) async {
    final repo = ref.read(checkInRepositoryProvider);
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await repo.submitCheckIn(visitor);
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, successData: result);
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: 'Check-in failed. Please check network connection.',
      );
    }
  }

  void reset() {
    state = CheckInState();
  }
}

final checkInControllerProvider =
    NotifierProvider.autoDispose<CheckInController, CheckInState>(
      CheckInController.new,
    );
