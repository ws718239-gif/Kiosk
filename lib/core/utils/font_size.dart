import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Font Size Utility using GoogleFonts.manrope with larger sizes for Tablet Kiosks.
class AppFonts {
  static TextStyle manrope({
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return GoogleFonts.manrope(
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  // Extra Large / Big Kiosk Typography Scale
  static TextStyle displayLarge({Color? color}) => manrope(
    fontSize: 48.sp,
    fontWeight: FontWeight.bold,
    color: color,
    letterSpacing: -0.5,
  );

  static TextStyle displayMedium({Color? color}) =>
      manrope(fontSize: 42.sp, fontWeight: FontWeight.bold, color: color);

  static TextStyle displaySmall({Color? color}) =>
      manrope(fontSize: 36.sp, fontWeight: FontWeight.w600, color: color);

  static TextStyle headlineLarge({Color? color}) =>
      manrope(fontSize: 32.sp, fontWeight: FontWeight.bold, color: color);

  static TextStyle headlineMedium({Color? color}) =>
      manrope(fontSize: 28.sp, fontWeight: FontWeight.w600, color: color);

  static TextStyle headlineSmall({Color? color}) =>
      manrope(fontSize: 26.sp, fontWeight: FontWeight.w600, color: color);

  static TextStyle titleLarge({Color? color}) =>
      manrope(fontSize: 26.sp, fontWeight: FontWeight.bold, color: color);

  static TextStyle titleMedium({Color? color}) =>
      manrope(fontSize: 23.sp, fontWeight: FontWeight.w600, color: color);

  static TextStyle titleSmall({Color? color}) =>
      manrope(fontSize: 21.sp, fontWeight: FontWeight.w600, color: color);

  static TextStyle bodyLarge({Color? color}) =>
      manrope(fontSize: 23.sp, fontWeight: FontWeight.normal, color: color);

  static TextStyle bodyMedium({Color? color}) =>
      manrope(fontSize: 21.sp, fontWeight: FontWeight.normal, color: color);

  static TextStyle bodySmall({Color? color}) =>
      manrope(fontSize: 19.sp, fontWeight: FontWeight.normal, color: color);

  static TextStyle labelLarge({Color? color}) =>
      manrope(fontSize: 21.sp, fontWeight: FontWeight.bold, color: color);

  static TextStyle labelMedium({Color? color}) =>
      manrope(fontSize: 19.sp, fontWeight: FontWeight.w600, color: color);

  static TextStyle labelSmall({Color? color}) =>
      manrope(fontSize: 17.sp, fontWeight: FontWeight.w500, color: color);
}
