import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet connection and try again.';

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 400) {
          return 'Bad request. Please check your inputs.';
        }
        if (statusCode == 401) {
          return 'Unauthorized. Please login again.';
        }
        if (statusCode == 403) {
          return 'Forbidden. You do not have permission.';
        }
        if (statusCode == 404) {
          return 'Resource not found.';
        }
        if (statusCode == 500) {
          return 'Internal server error. Please try again later.';
        }
        return 'Received invalid status code: $statusCode';

      case DioExceptionType.cancel:
        return 'Request to API server was cancelled';

      case DioExceptionType.connectionError:
        return 'API server is unreachable. Check that it is running and the address is correct.';

      case DioExceptionType.unknown:
      default:
        if (error.message?.contains('SocketException') ?? false) {
          return 'No internet connection or server is unreachable.';
        }
        return 'Unexpected error occurred. Please try again.';
    }
  }
}
