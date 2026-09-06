import 'package:chatbot_project/common/components/app_toast.dart';
import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('success hiển thị toast thành công', (tester) async {
    final context = await _pumpToastHost(tester);

    AppToast.success(context, 'Thành công');
    await tester.pump();

    expect(find.text('Thành công'), findsOneWidget);
    expect(
      tester.widget<SnackBar>(find.byType(SnackBar)).backgroundColor,
      AppColorScheme.light.textSuccess,
    );
  });

  testWidgets('warning hiển thị toast cảnh báo', (tester) async {
    final context = await _pumpToastHost(tester);

    AppToast.warning(context, 'Cảnh báo');
    await tester.pump();

    expect(find.text('Cảnh báo'), findsOneWidget);
    expect(
      tester.widget<SnackBar>(find.byType(SnackBar)).backgroundColor,
      AppColorScheme.light.textBrand,
    );
  });

  testWidgets('failed hiển thị toast thất bại', (tester) async {
    final context = await _pumpToastHost(tester);

    AppToast.failed(context, 'Thất bại');
    await tester.pump();

    expect(find.text('Thất bại'), findsOneWidget);
    expect(
      tester.widget<SnackBar>(find.byType(SnackBar)).backgroundColor,
      AppColorScheme.light.textError,
    );
  });
}

Future<BuildContext> _pumpToastHost(WidgetTester tester) async {
  late BuildContext toastContext;
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) {
            toastContext = context;
            return const Scaffold();
          },
        ),
      ),
    ),
  );
  return toastContext;
}
