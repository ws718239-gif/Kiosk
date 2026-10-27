import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/network/exceptions/network_exceptions.dart';
import '../../../../core/i18n/app_strings.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../controllers/host_providers.dart';
import '../../domain/models/host_model.dart';

class HostDirectoryScreen extends ConsumerStatefulWidget {
  const HostDirectoryScreen({super.key});

  @override
  ConsumerState<HostDirectoryScreen> createState() =>
      _HostDirectoryScreenState();
}

class _HostDirectoryScreenState extends ConsumerState<HostDirectoryScreen> {
  final _scrollController = ScrollController();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    // Detect when scrolling near the bottom to trigger pagination
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(paginatedHostProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hostListAsync = ref.watch(hostListProvider);
    final paginatedState = ref.watch(paginatedHostProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Host'.tr(context)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
            child: AppSearchField(
              hintText: 'Search by name or department...'.tr(context),
              onChanged: (value) {
                _searchDebounce?.cancel();
                _searchDebounce = Timer(const Duration(milliseconds: 300), () {
                  if (mounted) {
                    ref
                        .read(hostSearchQueryProvider.notifier)
                        .updateQuery(value);
                  }
                });
              },
            ),
          ),
        ),
      ),
      body: hostListAsync.when(
        data: (_) {
          final hosts = paginatedState.visibleHosts;

          if (hosts.isEmpty) {
            return Center(child: Text('No Data Found'.tr(context)));
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(hostListProvider);
              try {
                await ref.read(hostListProvider.future);
              } catch (_) {
                // The refreshed provider state renders its normal error view.
              }
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: hosts.length + (paginatedState.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == hosts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final host = hosts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      child: _hostAvatar(host),
                    ),
                    title: Text(
                      host.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${host.department} • ${host.designation ?? "Host"}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to check-in form, passing the selected host
                      context.push('/checkin', extra: host);
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          String errorMessage = 'Something went wrong'.tr(context);
          if (error is DioException) {
            errorMessage = NetworkExceptions.getErrorMessage(error).tr(context);
          } else {
            errorMessage = 'Something went wrong'.tr(context);
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(hostListProvider),
                    child: Text('Retry'.tr(context)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _hostInitial(String name) => name.trim().isNotEmpty
      ? Text(name.trim()[0].toUpperCase())
      : const Icon(Icons.person);

  Widget _hostAvatar(HostModel host) {
    final avatarUrl = host.avatarUrl?.trim();
    if (avatarUrl == null || avatarUrl.isEmpty) {
      return _hostInitial(host.name);
    }

    final uri = Uri.tryParse(avatarUrl);
    if (uri == null ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return _hostInitial(host.name);
    }

    return Image.network(
      avatarUrl,
      width: 40,
      height: 40,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _hostInitial(host.name),
    );
  }
}
