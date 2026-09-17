import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';

import '../extensions/responsive_extension.dart';
import '../themes/theme_extensions/app_color_scheme.dart';
import 'app_text_style.dart';

class IrhButton extends StatelessWidget {
  const IrhButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.secondary = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final double? height;
  final bool secondary;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Container(
      height: height ?? 52.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondary ? colors.surfaceSecondary : null,
        borderRadius: BorderRadius.circular(16),
        border: secondary ? Border.all(color: colors.borderSecondary) : null,
      ),
      child: CupertinoButton(
        minimumSize: Size(44.width, 44.height),
        padding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 8.height),
        onPressed: loading ? null : onPressed,
        color: secondary ? null : colors.iconBrand,
        disabledColor: colors.borderPrimary,
        borderRadius: BorderRadius.circular(16),
        child: loading
            ? CupertinoActivityIndicator(
                color: secondary ? colors.iconBrand : colors.surfaceSecondary,
              )
            : Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyle.b16.copyWith(
                  color: secondary ? colors.textBrand : colors.surfaceSecondary,
                ),
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

class IrhOptionChip extends StatelessWidget {
  const IrhOptionChip({
    super.key,
    required this.label,
    required this.onPressed,
    this.selected = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Container(
      constraints: BoxConstraints(minHeight: 44.height),
      decoration: BoxDecoration(
        color: selected ? colors.iconBrand : colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.iconBrand),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 8.height),
        borderRadius: BorderRadius.circular(24),
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTextStyle.m14.copyWith(
            color: selected ? colors.surfaceSecondary : colors.textBrand,
          ),
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
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
    this.loading = false,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final contentColor = foregroundColor ?? colors.textPrimary;
    return Container(
      constraints: BoxConstraints(minHeight: 44.height),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: CupertinoButton(
        minimumSize: Size(44.width, 44.height),
        padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 8.height),
        borderRadius: BorderRadius.circular(12),
        onPressed: loading ? null : onPressed,
        child: loading
            ? CupertinoActivityIndicator(color: contentColor)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  4.width.widthBox,
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.m14.copyWith(color: contentColor),
                  ).expanded(),
                ],
              ),
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
