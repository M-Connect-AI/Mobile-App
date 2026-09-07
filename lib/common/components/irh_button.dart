import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extensions/responsive_extension.dart';
import '../themes/theme_extensions/app_color_scheme.dart';
import 'app_text_style.dart';

class IrhButton extends StatelessWidget {
  const IrhButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return SizedBox(
      height: 52.height,
      width: double.infinity,
      child: CupertinoButton(
        onPressed: onPressed,
        color: colors.iconBrand,
        disabledColor: colors.borderPrimary,
        borderRadius: BorderRadius.circular(16),
        child: Text(
          label,
          style: AppTextStyle.b16.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class IrhTextButton extends StatelessWidget {
  const IrhTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Text(
        label,
        style: AppTextStyle.m14.copyWith(
          color: context.appColorScheme.textBrand,
        ),
      ),
    );
  }
}

class IrhIconTextButton extends StatelessWidget {
  const IrhIconTextButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 12.height),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          8.width.widthBox,
          Text(label, style: AppTextStyle.m16),
        ],
      ),
    );
  }
}

class IrhRichTextButton extends StatelessWidget {
  const IrhRichTextButton({
    super.key,
    required this.text,
    required this.actionText,
    required this.onPressed,
  });

  final String text;
  final String actionText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Text.rich(
        TextSpan(
          text: text,
          style: AppTextStyle.r12.copyWith(
            color: context.appColorScheme.textSecondary,
          ),
          children: [
            TextSpan(
              text: actionText,
              style: AppTextStyle.sm12.copyWith(
                color: context.appColorScheme.textBrand,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
