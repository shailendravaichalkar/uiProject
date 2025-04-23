import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/main.dart';

class HotelAppTheme {
  static const String _fontName = 'WorkSans';

  static final Color primaryColor = HexColor('#54D3C2');
  static final Color secondaryColor = HexColor('#54D3C2');

  /// Define a global color scheme to be used throughout the app
  static final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ).copyWith(
    secondary: secondaryColor,
    error: const Color(0xFFB00020),
  );

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontFamily: _fontName),
      displayMedium: base.displayMedium?.copyWith(fontFamily: _fontName),
      displaySmall: base.displaySmall?.copyWith(fontFamily: _fontName),
      headlineMedium: base.headlineMedium?.copyWith(fontFamily: _fontName),
      headlineSmall: base.headlineSmall?.copyWith(fontFamily: _fontName),
      titleLarge: base.titleLarge?.copyWith(fontFamily: _fontName),
      labelLarge: base.labelLarge?.copyWith(fontFamily: _fontName),
      bodySmall: base.bodySmall?.copyWith(fontFamily: _fontName),
      bodyLarge: base.bodyLarge?.copyWith(fontFamily: _fontName),
      bodyMedium: base.bodyMedium?.copyWith(fontFamily: _fontName),
      titleMedium: base.titleMedium?.copyWith(fontFamily: _fontName),
      titleSmall: base.titleSmall?.copyWith(fontFamily: _fontName),
      labelSmall: base.labelSmall?.copyWith(fontFamily: _fontName),
    );
  }

  static ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}
