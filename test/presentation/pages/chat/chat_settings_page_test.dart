import 'dart:async';

import 'package:chatbot_project/domain/repository/chat_text_size_repository.dart';
import 'package:chatbot_project/common/extensions/responsive_extension.dart';
import 'package:chatbot_project/common/components/assistant_header.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/chat/bloc/chat_text_size_cubit.dart';
import 'package:chatbot_project/presentation/pages/chat/chat_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide SizeExtension;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'loads the saved size without replacing a newer slider choice',
    () async {
      final pendingRead = Completer<int?>();
      final repository = _MemoryTextSizeRepository(
        onRead: () => pendingRead.future,
      );
      final cubit = ChatTextSizeCubit(repository);
      final load = cubit.load();

      cubit.update(22);
      pendingRead.complete(18);
      await load;
      expect(cubit.state, 22);

      expect(await cubit.save(), isTrue);
      expect(repository.savedSize, 22);
      await cubit.close();

      final reopened = ChatTextSizeCubit(repository);
      await reopened.load();
      expect(reopened.state, 22);
      reopened.update(11);
      expect(reopened.state, ChatTextSizeCubit.minSize);
      reopened.update(25);
      expect(reopened.state, ChatTextSizeCubit.maxSize);
      await reopened.close();
    },
  );

  testWidgets(
    'slider updates the real chat bubble preview and saves the choice',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final repository = _MemoryTextSizeRepository(savedSize: 18);
      final cubit = ChatTextSizeCubit(repository)..load();
      addTearDown(cubit.close);
      await tester.pumpWidget(_SettingsTestApp(cubit: cubit));
      await tester.pump();

      expect(cubit.state, 18);
      expect(find.text(S.current.chatTextSizeValue(18)), findsOneWidget);
      final preview = find.text(S.current.chatTextSizePreviewMessage);
      expect(tester.widget<Text>(preview).style?.fontSize, 18.sp);

      final slider = tester.getRect(
        find.byKey(const Key('chat-text-size-slider')),
      );
      await tester.dragFrom(
        Offset(slider.center.dx, slider.center.dy),
        const Offset(300, 0),
      );
      await tester.pump();

      expect(cubit.state, ChatTextSizeCubit.maxSize);
      expect(
        tester.widget<Text>(preview).style?.fontSize,
        ChatTextSizeCubit.maxSize.sp,
      );
      expect(repository.savedSize, ChatTextSizeCubit.maxSize);
    },
  );

  testWidgets('settings fits on a narrow screen', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.binding.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue,
    );

    final cubit = ChatTextSizeCubit(_MemoryTextSizeRepository());
    addTearDown(cubit.close);
    await tester.pumpWidget(_SettingsTestApp(cubit: cubit));
    await tester.pump();

    expect(find.byKey(const Key('chat-text-size-slider')), findsOneWidget);
    expect(find.byKey(const Key('chat-text-size-preview')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(AssistantHeader),
        matching: find.byType(CupertinoButton),
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}

class _MemoryTextSizeRepository implements ChatTextSizeRepository {
  _MemoryTextSizeRepository({this.savedSize, this.onRead});

  int? savedSize;
  Future<int?> Function()? onRead;

  @override
  Future<int?> read() async {
    final readOnce = onRead;
    onRead = null;
    return readOnce != null ? readOnce() : savedSize;
  }

  @override
  Future<void> save(int size) async {
    savedSize = size;
  }
}

class _SettingsTestApp extends StatelessWidget {
  const _SettingsTestApp({required this.cubit});

  final ChatTextSizeCubit cubit;

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, child) => BlocProvider.value(
      value: cubit,
      child: MaterialApp(
        locale: const Locale('vi'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const ChatSettingsPage(),
      ),
    ),
  );
}
