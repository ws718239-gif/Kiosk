import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

import 'core/i18n/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme_provider.dart';
import 'core/utils/font_size.dart';

class KioskApp extends ConsumerWidget {
  const KioskApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers for state changes
    final goRouter = ref.watch(appRouterProvider);
    final themeSettings = ref.watch(themeSettingsProvider);
    final locale = ref.watch(localeProvider);

    return ScreenUtilInit(
      designSize: const Size(800, 1280), // Standard Tablet Kiosk Design Size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Kiosk',
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            final isDark = switch (themeSettings.themeMode) {
              ThemeMode.dark => true,
              ThemeMode.light => false,
              ThemeMode.system =>
                mediaQuery.platformBrightness == Brightness.dark,
            };
            final systemUiStyle = SystemUiOverlayStyle(
              statusBarColor: isDark
                  ? const Color(0xFF0F141C)
                  : const Color(0xFFF8F9FA),
              statusBarIconBrightness: isDark
                  ? Brightness.light
                  : Brightness.dark,
              statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
              systemNavigationBarColor: isDark
                  ? const Color(0xFF0F141C)
                  : const Color(0xFFF8F9FA),
              systemNavigationBarIconBrightness: isDark
                  ? Brightness.light
                  : Brightness.dark,
              systemStatusBarContrastEnforced: false,
              systemNavigationBarContrastEnforced: false,
            );
            final systemBarBackground = isDark
                ? const Color(0xFF0F141C)
                : const Color(0xFFF8F9FA);

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemUiStyle,
              child: ColoredBox(
                color: systemBarBackground,
                child: MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: const TextScaler.linear(1.2),
                  ),
                  child: SafeArea(child: child ?? const SizedBox.shrink()),
                ),
              ),
            );
          },

          // Modern-Classic Theme Configuration with AppFonts & Larger Font Scale
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeSettings.seedColor,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            textTheme: TextTheme(
              displayLarge: AppFonts.displayLarge(),
              displayMedium: AppFonts.displayMedium(),
              displaySmall: AppFonts.displaySmall(),
              headlineLarge: AppFonts.headlineLarge(),
              headlineMedium: AppFonts.headlineMedium(),
              headlineSmall: AppFonts.headlineSmall(),
              titleLarge: AppFonts.titleLarge(),
              titleMedium: AppFonts.titleMedium(),
              titleSmall: AppFonts.titleSmall(),
              bodyLarge: AppFonts.bodyLarge(),
              bodyMedium: AppFonts.bodyMedium(),
              bodySmall: AppFonts.bodySmall(),
              labelLarge: AppFonts.labelLarge(),
              labelMedium: AppFonts.labelMedium(),
              labelSmall: AppFonts.labelSmall(),
            ),
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              titleTextStyle: AppFonts.titleLarge(color: Colors.black87),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color(0xFFF8F9FA),
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Color(0xFFF8F9FA),
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarDividerColor: Color(0xFFE2E5E9),
                systemStatusBarContrastEnforced: false,
                systemNavigationBarContrastEnforced: false,
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              surfaceTintColor: Colors.white,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              errorStyle: AppFonts.bodySmall(color: Colors.red),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              hintStyle: AppFonts.bodyMedium(color: Colors.grey),
              labelStyle: AppFonts.bodyMedium(color: Colors.grey),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeSettings.seedColor,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            textTheme: TextTheme(
              displayLarge: AppFonts.displayLarge(color: Colors.white),
              displayMedium: AppFonts.displayMedium(color: Colors.white),
              displaySmall: AppFonts.displaySmall(color: Colors.white),
              headlineLarge: AppFonts.headlineLarge(color: Colors.white),
              headlineMedium: AppFonts.headlineMedium(color: Colors.white),
              headlineSmall: AppFonts.headlineSmall(color: Colors.white),
              titleLarge: AppFonts.titleLarge(color: Colors.white),
              titleMedium: AppFonts.titleMedium(color: Colors.white),
              titleSmall: AppFonts.titleSmall(color: Colors.white),
              bodyLarge: AppFonts.bodyLarge(color: Colors.white70),
              bodyMedium: AppFonts.bodyMedium(color: Colors.white70),
              bodySmall: AppFonts.bodySmall(color: Colors.white60),
              labelLarge: AppFonts.labelLarge(color: Colors.white),
              labelMedium: AppFonts.labelMedium(color: Colors.white),
              labelSmall: AppFonts.labelSmall(color: Colors.white70),
            ),
            scaffoldBackgroundColor: const Color(0xFF0F141C),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              titleTextStyle: AppFonts.titleLarge(color: Colors.white),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color(0xFF0F141C),
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: Color(0xFF0F141C),
                systemNavigationBarIconBrightness: Brightness.light,
                systemNavigationBarDividerColor: Color(0xFF242D3A),
                systemStatusBarContrastEnforced: false,
                systemNavigationBarContrastEnforced: false,
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: const Color(0xFF181F2C),
              surfaceTintColor: const Color(0xFF181F2C),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF181F2C),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              errorStyle: AppFonts.bodySmall(color: Colors.redAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 2,
                ),
              ),
              hintStyle: AppFonts.bodyMedium(color: Colors.white54),
              labelStyle: AppFonts.bodyMedium(color: Colors.white54),
            ),
          ),
          themeMode: themeSettings.themeMode,

          // Dynamic Localization based on Admin Settings
          locale: locale,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('hi', 'IN'),
            Locale('gu', 'IN'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // Routing via GoRouter
          routerConfig: goRouter,
        );
      },
    );
  }
}
