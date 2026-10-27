import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/models/host_model.dart';

class HostRepository {
  final Dio _dio;

  HostRepository(this._dio);

  Future<List<HostModel>> fetchHosts({
    String? query,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(
      ApiConstants.hosts,
      queryParameters: {
        if (query != null && query.trim().isNotEmpty) 'q': query.trim(),
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 204 || response.data == null) {
      return [];
    }

    if (response.statusCode != 200) {
      throw const FormatException('Unexpected hosts response status.');
    }

    final responseData = response.data;
    final dynamic rawItems = responseData is List
        ? responseData
        : responseData is Map
        ? responseData['items'] ?? const []
        : null;
    if (rawItems is! List) {
      throw const FormatException('Hosts response must contain an items list.');
    }

    return rawItems
        .map((json) {
          if (json is! Map) {
            throw const FormatException('Host record must be an object.');
          }
          return HostModel.fromJson(Map<String, dynamic>.from(json));
        })
        .toList(growable: false);
  }
}

final hostRepositoryProvider = Provider<HostRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return HostRepository(dio);
});
