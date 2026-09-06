import 'package:flutter/material.dart';

import '../themes/theme_extensions/app_color_scheme.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFFF4600C);

  static ThemeData get light => _build(Brightness.light, AppColorScheme.light);

  static ThemeData get dark => _build(Brightness.dark, AppColorScheme.dark);

  static ThemeData _build(Brightness brightness, AppColorScheme appColors) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
      surface: appColors.surfacePrimary,
    ).copyWith(primary: _seed);
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: appColors.surfacePrimary,
      extensions: [appColors],
    );
  }
}
