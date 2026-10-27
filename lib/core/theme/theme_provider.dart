import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/shared_prefs.dart';

class ThemeSettings {
  final ThemeMode themeMode;
  final Color seedColor;

  ThemeSettings({required this.themeMode, required this.seedColor});

  ThemeSettings copyWith({ThemeMode? themeMode, Color? seedColor}) {
    return ThemeSettings(
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
    );
  }
}

class ThemeSettingsNotifier extends Notifier<ThemeSettings> {
  static const _isDarkKey = 'theme_is_dark';
  static const _colorKey = 'theme_brand_color';

  @override
  ThemeSettings build() {
    final prefs = ref.watch(sharedPrefsProvider);

    // Read from local storage
    final isDark = prefs.getBool(_isDarkKey);
    final colorValue = prefs.getInt(_colorKey);

    ThemeMode mode = ThemeMode.system;
    if (isDark != null) {
      mode = isDark ? ThemeMode.dark : ThemeMode.light;
    }

    Color color = Colors.blue; // Default brand color
    if (colorValue != null) {
      color = Color(colorValue);
    }

    return ThemeSettings(themeMode: mode, seedColor: color);
  }

  void toggleTheme(bool isDark) {
    final prefs = ref.read(sharedPrefsProvider);
    prefs.setBool(_isDarkKey, isDark);
    state = state.copyWith(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void setBrandColor(Color color) {
    final prefs = ref.read(sharedPrefsProvider);
    prefs.setInt(_colorKey, color.toARGB32());
    state = state.copyWith(seedColor: color);
  }
}

final themeSettingsProvider =
    NotifierProvider<ThemeSettingsNotifier, ThemeSettings>(
      ThemeSettingsNotifier.new,
    );
