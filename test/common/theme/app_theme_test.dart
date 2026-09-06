import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const brandColor = Color(0xFFF4600C);

  test('light theme uses the orange brand color and Roboto', () {
    final theme = AppTheme.light;

    expect(theme.colorScheme.primary, brandColor);
    expect(theme.textTheme.bodyMedium?.fontFamily, 'Roboto');
    expect(theme.extension<AppColorScheme>()?.iconBrand, brandColor);
  });

  test('dark theme uses the orange brand color and Roboto', () {
    final theme = AppTheme.dark;

    expect(theme.colorScheme.primary, brandColor);
    expect(theme.textTheme.bodyMedium?.fontFamily, 'Roboto');
    expect(theme.extension<AppColorScheme>()?.iconBrand, brandColor);
  });
}
