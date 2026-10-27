import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../../visitor_checkin/domain/models/visitor_model.dart';

class PaginatedVisitorsResult {
  final List<VisitorModel> items;
  final String? nextCursor;

  PaginatedVisitorsResult({required this.items, this.nextCursor});
}

class TodayVisitorsRepository {
  final Dio _dio;

  TodayVisitorsRepository(this._dio);

  Future<PaginatedVisitorsResult> fetchTodayVisitors({
    String? cursor,
    int limit = 20,
    String? status,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(
      '/visitors',
      queryParameters: {
        'limit': limit,
        'cursor': ?cursor,
        if (status != null && status != 'All') 'status': status,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 204 || response.data == null) {
      return PaginatedVisitorsResult(items: const [], nextCursor: null);
    }

    if (response.statusCode != 200) {
      throw const FormatException('Unexpected visitors response status.');
    }

    final responseData = response.data;
    final dynamic rawItems = responseData is List
        ? responseData
        : responseData is Map
        ? responseData['items'] ?? const []
        : null;
    if (rawItems is! List) {
      throw const FormatException(
        'Visitors response must contain an items list.',
      );
    }

    final visitors = rawItems
        .map((json) {
          if (json is! Map) {
            throw const FormatException('Visitor record must be an object.');
          }
          return VisitorModel.fromJson(Map<String, dynamic>.from(json));
        })
        .toList(growable: false);

    final rawCursor = responseData is Map ? responseData['nextCursor'] : null;
    if (rawCursor != null && rawCursor is! String) {
      throw const FormatException('Visitor cursor must be a string.');
    }

    return PaginatedVisitorsResult(
      items: visitors,
      nextCursor: rawCursor as String?,
    );
  }
}

final todayVisitorsRepositoryProvider = Provider<TodayVisitorsRepository>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return TodayVisitorsRepository(dio);
});
