import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../data/repositories/host_repository.dart';
import '../../domain/models/host_model.dart';

// 1. Holds the current search query typed by the user
class HostSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }
}

final hostSearchQueryProvider =
    NotifierProvider.autoDispose<HostSearchQueryNotifier, String>(
      HostSearchQueryNotifier.new,
    );

// 2. Fetches the host list from API, passing 'q' search parameter to server
final hostListProvider = FutureProvider.autoDispose<List<HostModel>>((
  ref,
) async {
  final repository = ref.watch(hostRepositoryProvider);
  final query = ref.watch(hostSearchQueryProvider);
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  return repository.fetchHosts(query: query, cancelToken: cancelToken);
});

// 3. Paginated Host State for Smooth Infinite Scrolling
class PaginatedHostState {
  final List<HostModel> visibleHosts;
  final bool hasMore;
  final int page;
  final bool isLoadingMore;

  PaginatedHostState({
    this.visibleHosts = const [],
    this.hasMore = true,
    this.page = 1,
    this.isLoadingMore = false,
  });

  PaginatedHostState copyWith({
    List<HostModel>? visibleHosts,
    bool? hasMore,
    int? page,
    bool? isLoadingMore,
  }) {
    return PaginatedHostState(
      visibleHosts: visibleHosts ?? this.visibleHosts,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class PaginatedHostNotifier extends Notifier<PaginatedHostState> {
  static const int pageSize = 20;

  @override
  PaginatedHostState build() {
    final rawListAsync = ref.watch(hostListProvider);

    final hosts = rawListAsync.maybeWhen(
      data: (list) => list,
      orElse: () => <HostModel>[],
    );

    final initialCount = hosts.length > pageSize ? pageSize : hosts.length;
    return PaginatedHostState(
      visibleHosts: hosts.take(initialCount).toList(),
      hasMore: hosts.length > initialCount,
      page: 1,
      isLoadingMore: false,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    // Brief delay to ensure smooth loader animation
    await Future.delayed(const Duration(milliseconds: 300));
    if (!ref.mounted) return;

    final rawListAsync = ref.read(hostListProvider);
    final hosts = rawListAsync.maybeWhen(
      data: (list) => list,
      orElse: () => <HostModel>[],
    );

    final nextPage = state.page + 1;
    final nextCount = nextPage * pageSize;
    final currentCount = nextCount > hosts.length ? hosts.length : nextCount;

    state = state.copyWith(
      visibleHosts: hosts.take(currentCount).toList(),
      hasMore: hosts.length > currentCount,
      page: nextPage,
      isLoadingMore: false,
    );
  }
}

final paginatedHostProvider =
    NotifierProvider.autoDispose<PaginatedHostNotifier, PaginatedHostState>(
      PaginatedHostNotifier.new,
    );
