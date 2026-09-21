import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';

import '../extensions/responsive_extension.dart';
import '../themes/theme_extensions/app_color_scheme.dart';
import 'irh_text.dart';

class AssistantHeader extends StatelessWidget {
  const AssistantHeader({
    super.key,
    required this.title,
    this.backLabel,
    this.onBack,
    this.trailingLabel,
    this.onTrailing,
    this.backKey,
    this.trailingKey,
    this.trailingIcon = CupertinoIcons.xmark,
  });

  final String title;
  final String? backLabel;
  final VoidCallback? onBack;
  final String? trailingLabel;
  final VoidCallback? onTrailing;
  final Key? backKey;
  final Key? trailingKey;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return SizedBox(
      height: 64.height,
      child: Row(
        children: [
          if (onBack != null && backLabel != null)
            _HeaderAction(
              key: backKey,
              label: backLabel!,
              icon: CupertinoIcons.back,
              onPressed: onBack,
            )
          else
            SizedBox(width: 48.width),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surfaceSecondary,
                borderRadius: BorderRadius.circular(28),
              ),
              child: IrhText.medium(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 16.width, vertical: 12.height),
            ),
          ).expanded(),
          if (onTrailing != null && trailingLabel != null)
            _HeaderAction(
              key: trailingKey,
              label: trailingLabel!,
              icon: trailingIcon,
              onPressed: onTrailing,
            )
          else
            SizedBox(width: 48.width),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: CupertinoButton(
        minimumSize: Size(48.width, 48.height),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          width: 48.width,
          height: 48.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.surfaceSecondary,
            shape: BoxShape.circle,
            border: Border.all(color: colors.borderPrimary),
          ),
          child: Icon(icon, color: colors.iconPrimary, size: 24.sp),
        ),
      ),
    );
  }
}
