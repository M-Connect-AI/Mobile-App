import 'package:chatbot_project/data/source/remote/client/dio_client_factory.dart';
import 'package:chatbot_project/common/navigation/root_navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/core/alice_dio_interceptor.dart';
import 'package:flutter_alice/core/debug_pop_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('tắt bong bóng vẫn giữ Alice interceptor ở mọi Dio client', () {
    DioClientFactory.setBubbleEnabled(false);
    final existing = DioClientFactory.create();
    expect(
      existing.interceptors.whereType<AliceDioInterceptor>(),
      hasLength(1),
    );
    expect(
      existing.interceptors
          .whereType<AliceDioInterceptor>()
          .single
          .aliceCore
          .showNotification,
      isFalse,
    );

    DioClientFactory.setBubbleEnabled(true);
    expect(
      existing.interceptors.whereType<AliceDioInterceptor>(),
      hasLength(1),
    );

    final createdAfterEnable = DioClientFactory.create();
    expect(
      createdAfterEnable.interceptors.whereType<AliceDioInterceptor>(),
      hasLength(1),
    );

    DioClientFactory.setBubbleEnabled(false);
    expect(
      existing.interceptors.whereType<AliceDioInterceptor>(),
      hasLength(1),
    );
    expect(
      createdAfterEnable.interceptors.whereType<AliceDioInterceptor>(),
      hasLength(1),
    );
  });

  testWidgets('switch hiện và ẩn bong bóng Alice ngay', (tester) async {
    DioClientFactory.setBubbleEnabled(false);
    await tester.pumpWidget(
      OverlaySupport(
        child: MaterialApp(
          navigatorKey: rootNavigatorKey,
          home: const Scaffold(),
        ),
      ),
    );
    expect(find.byType(DebugPopUp), findsNothing);

    DioClientFactory.setBubbleEnabled(true);
    await tester.pump();
    expect(find.byType(DebugPopUp), findsOneWidget);

    DioClientFactory.setBubbleEnabled(false);
    await tester.pump();
    expect(find.byType(DebugPopUp), findsNothing);
  });
}
