import 'package:flutter/material.dart';

import '../extensions/responsive_extension.dart';

abstract final class AppTextStyle {
  static const _fontFamily = 'Roboto';

  static TextStyle _style(double size, FontWeight weight) =>
      TextStyle(fontFamily: _fontFamily, fontSize: size.sp, fontWeight: weight);

  static TextStyle get r12 => _style(12, FontWeight.w400);
  static TextStyle get r16 => _style(16, FontWeight.w400);
  static TextStyle get m12 => _style(12, FontWeight.w500);
  static TextStyle get m16 => _style(16, FontWeight.w500);
  static TextStyle get sm12 => _style(12, FontWeight.w600);
  static TextStyle get sm16 => _style(16, FontWeight.w600);
  static TextStyle get b16 => _style(16, FontWeight.w700);
  static TextStyle get b20 => _style(20, FontWeight.w700);
  static TextStyle get b24 => _style(24, FontWeight.w700);
  static TextStyle get b28 => _style(28, FontWeight.w700);
}
