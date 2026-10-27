import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../visitor_checkin/domain/models/visitor_model.dart';
import '../../data/repositories/today_visitors_repository.dart';

class TodayVisitorsState {
  final List<VisitorModel> visitors;
  final String? nextCursor;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final String? error;
  final String statusFilter;

  TodayVisitorsState({
    this.visitors = const [],
    this.nextCursor,
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.error,
    this.statusFilter = 'All',
  });

  bool get hasMore => nextCursor != null && nextCursor!.isNotEmpty;

  TodayVisitorsState copyWith({
    List<VisitorModel>? visitors,
    String? nextCursor,
    bool? isInitialLoading,
    bool? isLoadingMore,
    String? error,
    String? statusFilter,
    bool clearNextCursor = false,
  }) {
    return TodayVisitorsState(
      visitors: visitors ?? this.visitors,
      nextCursor: clearNextCursor ? nextCursor : nextCursor ?? this.nextCursor,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }
}

class TodayVisitorsNotifier extends Notifier<TodayVisitorsState> {
  int _fetchGeneration = 0;
  CancelToken? _activeRequest;

  @override
  TodayVisitorsState build() {
    ref.onDispose(() => _activeRequest?.cancel());
    Future.microtask(() => fetchInitial());
    return TodayVisitorsState();
  }

  void updateStatusFilter(String status) {
    if (state.statusFilter == status) return;
    state = state.copyWith(
      statusFilter: status,
      visitors: [],
      clearNextCursor: true,
      isLoadingMore: false,
    );
    fetchInitial();
  }

  Future<void> fetchInitial() async {
    if (!ref.mounted) return;
    final generation = ++_fetchGeneration;
    final status = state.statusFilter;
    _activeRequest?.cancel();
    final cancelToken = CancelToken();
    _activeRequest = cancelToken;
    state = state.copyWith(
      isInitialLoading: true,
      isLoadingMore: false,
      error: null,
    );
    try {
      final repo = ref.read(todayVisitorsRepositoryProvider);
      final result = await repo.fetchTodayVisitors(
        limit: 20,
        status: status,
        cancelToken: cancelToken,
      );
      if (!ref.mounted || generation != _fetchGeneration) return;
      state = state.copyWith(
        visitors: result.items,
        nextCursor: result.nextCursor,
        clearNextCursor: true,
        isInitialLoading: false,
      );
    } catch (e) {
      if (!ref.mounted || generation != _fetchGeneration) return;
      state = state.copyWith(
        isInitialLoading: false,
        error: 'Failed to load visitors. Please retry.',
      );
    }
  }

  Future<void> fetchMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isInitialLoading) return;

    final generation = _fetchGeneration;
    final cursor = state.nextCursor;
    final status = state.statusFilter;
    final cancelToken = CancelToken();
    _activeRequest = cancelToken;
    state = state.copyWith(isLoadingMore: true);
    try {
      final repo = ref.read(todayVisitorsRepositoryProvider);
      final result = await repo.fetchTodayVisitors(
        cursor: cursor,
        limit: 20,
        status: status,
        cancelToken: cancelToken,
      );
      if (!ref.mounted || generation != _fetchGeneration) return;
      state = state.copyWith(
        visitors: [...state.visitors, ...result.items],
        nextCursor: result.nextCursor == cursor ? null : result.nextCursor,
        clearNextCursor: true,
        isLoadingMore: false,
      );
    } catch (e) {
      if (!ref.mounted || generation != _fetchGeneration) return;
      state = state.copyWith(isLoadingMore: false);
    }
  }
}

final todayVisitorsProvider =
    NotifierProvider.autoDispose<TodayVisitorsNotifier, TodayVisitorsState>(
      TodayVisitorsNotifier.new,
    );
