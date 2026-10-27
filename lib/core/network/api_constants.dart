import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

class ApiConstants {
  // To avoid instantiation
  ApiConstants._();

  /// Can be overridden per device/environment, for example:
  /// `--dart-define=API_BASE_URL=http://192.168.1.25:4000`
  static const String _configuredBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
  );
  static const bool _allowInsecureApi = bool.fromEnvironment(
    'ALLOW_INSECURE_API',
  );

  /// Defines the base URL for the Mock API.
  /// Physical devices must use the development computer's reachable LAN IP.
  static String get baseUrl {
    final String url;
    if (_configuredBaseUrl.isNotEmpty) {
      url = _configuredBaseUrl;
    } else if (kIsWeb) {
      url = 'http://localhost:4000';
    } else {
      // Android Emulator forwards 10.0.2.2 to the development computer.
      // Physical tablets need their reachable API address via API_BASE_URL.
      url = 'http://10.0.2.2:4000';
    }

    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      throw StateError('API_BASE_URL must be a valid absolute URL.');
    }
    if (kReleaseMode && uri.scheme != 'https' && !_allowInsecureApi) {
      throw StateError(
        'Release builds require HTTPS. Set ALLOW_INSECURE_API=true only '
        'for a local assessment mock API.',
      );
    }

    return url;
  }

  // Network Timeouts
  static const int connectionTimeout = 10000; // 10 seconds
  static const int receiveTimeout = 15000; // 15 seconds

  // Endpoints (Corrected according to Mock API server.js)
  static const String hosts = '/hosts';
  static const String checkin = '/visitors';
  static const String todayVisitors = '/visitors';
}
