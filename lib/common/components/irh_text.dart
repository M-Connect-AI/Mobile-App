import 'package:flutter/material.dart';

import '../themes/theme_extensions/app_color_scheme.dart';
import 'app_text_style.dart';

abstract final class IrhText {
  static Widget title(
    String value, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) => Builder(
    builder: (context) => Text(
      value,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: AppTextStyle.b20.copyWith(
        color: color ?? context.appColorScheme.textPrimary,
      ),
    ),
  );

  static Widget small(
    String value, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) => Builder(
    builder: (context) => Text(
      value,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: AppTextStyle.r12.copyWith(
        color: color ?? context.appColorScheme.textSecondary,
      ),
    ),
  );

  static Widget regular(
    String value, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) => Builder(
    builder: (context) => Text(
      value,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: AppTextStyle.r16.copyWith(
        color: color ?? context.appColorScheme.textPrimary,
      ),
    ),
  );

  static Widget medium(
    String value, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) => Builder(
    builder: (context) => Text(
      value,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: AppTextStyle.m16.copyWith(
        color: color ?? context.appColorScheme.textPrimary,
      ),
    ),
  );
}
