import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../controllers/today_visitors_providers.dart';
import '../../../../core/i18n/app_strings.dart';

class TodayVisitorsScreen extends ConsumerStatefulWidget {
  const TodayVisitorsScreen({super.key});

  @override
  ConsumerState<TodayVisitorsScreen> createState() =>
      _TodayVisitorsScreenState();
}

class _TodayVisitorsScreenState extends ConsumerState<TodayVisitorsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    // Detect when user scrolls near the bottom of the list
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(todayVisitorsProvider.notifier).fetchMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todayVisitorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Visitors".tr(context)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: Row(
              children: [
                _buildFilterChip('All', state.statusFilter),
                const SizedBox(width: 8),
                _buildFilterChip('checked_in', state.statusFilter),
                const SizedBox(width: 8),
                _buildFilterChip('checked_out', state.statusFilter),
                const SizedBox(width: 8),
                _buildFilterChip('expected', state.statusFilter),
              ],
            ),
          ),
        ),
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildFilterChip(String value, String currentStatus) {
    final label = value == 'checked_in'
        ? 'Checked In'.tr(context)
        : value == 'checked_out'
        ? 'Checked Out'.tr(context)
        : value == 'expected'
        ? 'Expected'.tr(context)
        : 'All'.tr(context);
    return ChoiceChip(
      label: Text(label),
      selected: currentStatus == value,
      onSelected: (selected) {
        if (selected) {
          ref.read(todayVisitorsProvider.notifier).updateStatusFilter(value);
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, TodayVisitorsState state) {
    if (state.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.visitors.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                state.error!.tr(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(todayVisitorsProvider.notifier).fetchInitial(),
                child: Text('Retry'.tr(context)),
              ),
            ],
          ),
        ),
      );
    }

    if (state.visitors.isEmpty) {
      return Center(child: Text('No Data Found'.tr(context)));
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(todayVisitorsProvider.notifier).fetchInitial(),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8.0),
        itemCount: state.visitors.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.visitors.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final visitor = state.visitors[index];
          final photoBytes = _decodeVisitorPhoto(visitor.photo);

          String timeStr = 'Just now'.tr(context);
          if (visitor.checkInAt != null) {
            try {
              final checkInTime = DateTime.parse(visitor.checkInAt!);
              timeStr = DateFormat.jm(
                Localizations.localeOf(context).toString(),
              ).format(checkInTime);
            } catch (_) {}
          }

          String statusText = 'Expected'.tr(context);
          Color statusColor = Colors.orange;

          if (visitor.status == 'checked_in') {
            statusText = 'Checked In'.tr(context);
            statusColor = Colors.green;
          } else if (visitor.status == 'checked_out') {
            statusText = 'Checked Out'.tr(context);
            statusColor = Colors.grey;
          }

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .secondaryContainer,
                child: photoBytes == null
                    ? const Icon(Icons.person)
                    : Image.memory(
                        photoBytes,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person),
                      ),
              ),
              title: Text(
                visitor.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Meeting: Host {host}\nPurpose: {purpose}'.tr(context, {
                  'host': visitor.hostName ?? visitor.hostId,
                  'purpose': _localizedPurpose(visitor.purpose, context),
                }),
              ),
              isThreeLine: true,
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      statusText,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(timeStr, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _localizedPurpose(String purpose, BuildContext context) {
    const purposeLabels = {
      'meeting': 'Meeting',
      'interview': 'Interview',
      'delivery': 'Delivery',
      'vendor': 'Vendor / Contractor',
      'maintenance': 'Maintenance',
      'personal': 'Personal',
    };
    return (purposeLabels[purpose] ?? purpose).tr(context);
  }
}

Uint8List? _decodeVisitorPhoto(String? photo) {
  if (photo == null || photo.isEmpty) return null;

  final separatorIndex = photo.indexOf(',');
  final encoded = separatorIndex >= 0
      ? photo.substring(separatorIndex + 1)
      : photo;
  if (encoded.length > 2 * 1024 * 1024) return null;

  try {
    return base64Decode(base64.normalize(encoded));
  } on FormatException {
    return null;
  }
}
