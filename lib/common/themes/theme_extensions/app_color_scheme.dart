import 'package:flutter/material.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme({
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textBrand,
    required this.textError,
    required this.textSuccess,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceTemary,
    required this.borderPrimary,
    required this.borderSecondary,
    required this.borderTertiary,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconBrand,
    required this.userBubble,
    required this.userText,
  });

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textBrand;
  final Color textError;
  final Color textSuccess;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceTemary;
  final Color borderPrimary;
  final Color borderSecondary;
  final Color borderTertiary;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconBrand;
  final Color userBubble;
  final Color userText;

  static const light = AppColorScheme(
    textPrimary: Color(0xFF17171F),
    textSecondary: Color(0xFF5D5D6B),
    textTertiary: Color(0xFF8B8B98),
    textBrand: Color(0xFFF4600C),
    textError: Color(0xFFC93535),
    textSuccess: Color(0xFF218A5B),
    surfacePrimary: Color(0xFFF8F8FC),
    surfaceSecondary: Color(0xFFFFFFFF),
    surfaceTemary: Color(0xFFF0F0F7),
    borderPrimary: Color(0xFFD8D8E2),
    borderSecondary: Color(0xFFE5E5EE),
    borderTertiary: Color(0xFFF0F0F4),
    iconPrimary: Color(0xFF33333D),
    iconSecondary: Color(0xFF777785),
    iconBrand: Color(0xFFF4600C),
    userBubble: Color(0xFFF4600C),
    userText: Color(0xFFFFFFFF),
  );

  static const dark = AppColorScheme(
    textPrimary: Color(0xFFF6F6FA),
    textSecondary: Color(0xFFBCBCC7),
    textTertiary: Color(0xFF8C8C99),
    textBrand: Color(0xFFF4600C),
    textError: Color(0xFFFF8E8E),
    textSuccess: Color(0xFF70D9A6),
    surfacePrimary: Color(0xFF111216),
    surfaceSecondary: Color(0xFF1A1B21),
    surfaceTemary: Color(0xFF25262D),
    borderPrimary: Color(0xFF484954),
    borderSecondary: Color(0xFF34343E),
    borderTertiary: Color(0xFF292A31),
    iconPrimary: Color(0xFFE9E9EF),
    iconSecondary: Color(0xFFA4A4AF),
    iconBrand: Color(0xFFF4600C),
    userBubble: Color(0xFFF4600C),
    userText: Color(0xFFFFFFFF),
  );

  @override
  AppColorScheme copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textBrand,
    Color? textError,
    Color? textSuccess,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceTemary,
    Color? borderPrimary,
    Color? borderSecondary,
    Color? borderTertiary,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? iconBrand,
    Color? userBubble,
    Color? userText,
  }) {
    return AppColorScheme(
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textBrand: textBrand ?? this.textBrand,
      textError: textError ?? this.textError,
      textSuccess: textSuccess ?? this.textSuccess,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceTemary: surfaceTemary ?? this.surfaceTemary,
      borderPrimary: borderPrimary ?? this.borderPrimary,
      borderSecondary: borderSecondary ?? this.borderSecondary,
      borderTertiary: borderTertiary ?? this.borderTertiary,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      iconBrand: iconBrand ?? this.iconBrand,
      userBubble: userBubble ?? this.userBubble,
      userText: userText ?? this.userText,
    );
  }

  @override
  AppColorScheme lerp(covariant AppColorScheme? other, double t) {
    if (other == null) return this;
    return AppColorScheme(
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textBrand: Color.lerp(textBrand, other.textBrand, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceSecondary: Color.lerp(surfaceSecondary, other.surfaceSecondary, t)!,
      surfaceTemary: Color.lerp(surfaceTemary, other.surfaceTemary, t)!,
      borderPrimary: Color.lerp(borderPrimary, other.borderPrimary, t)!,
      borderSecondary: Color.lerp(borderSecondary, other.borderSecondary, t)!,
      borderTertiary: Color.lerp(borderTertiary, other.borderTertiary, t)!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      iconBrand: Color.lerp(iconBrand, other.iconBrand, t)!,
      userBubble: Color.lerp(userBubble, other.userBubble, t)!,
      userText: Color.lerp(userText, other.userText, t)!,
    );
  }
}

extension AppColorSchemeContext on BuildContext {
  AppColorScheme get appColorScheme => Theme.of(this).extension<AppColorScheme>() ?? AppColorScheme.light;
}
