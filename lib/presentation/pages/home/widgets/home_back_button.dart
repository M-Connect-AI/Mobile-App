import 'package:chatbot_project/common/extensions/responsive_extension.dart';
import 'package:chatbot_project/common/navigation/pop_or_go.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/cupertino.dart';

class HomeBackButton extends StatelessWidget {
  const HomeBackButton({super.key, required this.semanticLabel});

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: CupertinoButton(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(24),
        color: colors.surfaceTemary,
        onPressed: () => popOrGo(context, const HomeRoute().location),
        child: SizedBox(
          width: 48.width,
          height: 48.width,
          child: CustomPaint(
            painter: _BackArrowPainter(color: colors.iconPrimary),
          ),
        ),
      ),
    );
  }
}

class _BackArrowPainter extends CustomPainter {
  const _BackArrowPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width / 24
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(size.width * .58, size.height * .3)
      ..lineTo(size.width * .38, size.height * .5)
      ..lineTo(size.width * .58, size.height * .7);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BackArrowPainter oldDelegate) =>
      oldDelegate.color != color;
}
