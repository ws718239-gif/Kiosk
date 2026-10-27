import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/shared_prefs.dart';

class LocaleNotifier extends Notifier<Locale> {
  static const _localeKey = 'app_language_code';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPrefsProvider);
    final langCode = prefs.getString(_localeKey) ?? 'en';
    return Locale(langCode);
  }

  void setLocale(String languageCode) {
    final prefs = ref.read(sharedPrefsProvider);
    prefs.setString(_localeKey, languageCode);
    state = Locale(languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
