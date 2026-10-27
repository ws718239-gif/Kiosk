import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/models/visitor_model.dart';

class CheckInRepository {
  final Dio _dio;

  CheckInRepository(this._dio);

  Future<VisitorModel> submitCheckIn(VisitorModel visitor) async {
    final payload = visitor.toJson();
    if (utf8.encode(jsonEncode(payload)).length > 2 * 1024 * 1024) {
      throw const FormatException('Visitor check-in payload is too large.');
    }

    final response = await _dio.post(ApiConstants.checkin, data: payload);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw const FormatException('Unexpected check-in response status.');
    }

    if (response.data is! Map) {
      throw const FormatException('Check-in response must be an object.');
    }
    return VisitorModel.fromJson(Map<String, dynamic>.from(response.data));
  }
}

final checkInRepositoryProvider = Provider<CheckInRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CheckInRepository(dio);
});
