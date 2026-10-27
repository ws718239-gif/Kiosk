import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/utils/shared_prefs.dart';

void main() async {
  // Ensure widget binding is initialized before using platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences asynchronously before app startup
  final sharedPrefs = await SharedPreferences.getInstance();

  // Global error boundary for Flutter rendering exceptions
  FlutterError.onError = (details) {
    if (kDebugMode) FlutterError.presentError(details);
  };

  // Global error boundary for asynchronous platform/Dart exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) debugPrint('Async Error: $error\n$stack');
    return false;
  };

  // Run the app wrapped in Riverpod's ProviderScope for state management
  runApp(
    ProviderScope(
      overrides: [
        // Inject the initialized SharedPreferences globally for synchronous access
        sharedPrefsProvider.overrideWithValue(sharedPrefs),
      ],
      child: const KioskApp(),
    ),
  );
}
