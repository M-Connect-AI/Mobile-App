import 'package:flutter/material.dart';

import '../themes/theme_extensions/app_color_scheme.dart';

abstract final class AppToast {
  static void showSuccess(BuildContext context, String message) =>
      _show(context, message, context.appColorScheme.textSuccess);

  static void showError(BuildContext context, String message) =>
      _show(context, message, context.appColorScheme.textError);

  static void showWarning(BuildContext context, String message) =>
      _show(context, message, context.appColorScheme.textBrand);

  static void showInfo(BuildContext context, String message) =>
      _show(context, message, context.appColorScheme.iconBrand);

  static void _show(BuildContext context, String message, Color background) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: background,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
