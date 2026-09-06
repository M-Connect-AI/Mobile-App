import 'package:flutter/material.dart';

import '../themes/theme_extensions/app_color_scheme.dart';
import 'irh_text.dart';

abstract final class AppToast {
  static void success(BuildContext context, String message) =>
      _show(context, message, context.appColorScheme.textSuccess);

  static void warning(BuildContext context, String message) =>
      _show(context, message, context.appColorScheme.textBrand);

  static void failed(BuildContext context, String message) =>
      _show(context, message, context.appColorScheme.textError);

  static void showSuccess(BuildContext context, String message) =>
      success(context, message);

  static void showWarning(BuildContext context, String message) =>
      warning(context, message);

  static void showError(BuildContext context, String message) =>
      failed(context, message);

  static void _show(BuildContext context, String message, Color background) {
    final colors = context.appColorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: IrhText.medium(message, color: colors.surfaceSecondary),
          backgroundColor: background,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }
}
