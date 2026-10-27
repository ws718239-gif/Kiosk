import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for SharedPreferences to be accessed synchronously anywhere in the app.
/// This MUST be overridden in the main.dart ProviderScope with an initialized instance.
final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPrefsProvider must be overridden in ProviderScope',
  );
});
