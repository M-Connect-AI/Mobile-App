import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_alice/core/debug_pop_up.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../common/navigation/root_navigator_key.dart';

abstract final class DioClientFactory {
  static bool _bubbleEnabled = false;
  static OverlaySupportEntry? _bubbleEntry;
  static final Alice _alice = Alice(
    navigatorKey: rootNavigatorKey,
    showNotification: false,
  );

  static Dio create() {
    final dio = Dio();
    if (!kDebugMode) return dio;

    dio.interceptors.add(_alice.getDioInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
    return dio;
  }

  static void setBubbleEnabled(bool enabled) {
    if (!kDebugMode) return;
    _bubbleEnabled = enabled;
    if (enabled) {
      showBubbleIfEnabled();
    } else {
      _bubbleEntry?.dismiss(animate: false);
      _bubbleEntry = null;
    }
  }

  static void showBubbleIfEnabled() {
    if (!kDebugMode || !_bubbleEnabled || _bubbleEntry != null) return;
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;
    final core = _alice.getDioInterceptor().aliceCore;
    _bubbleEntry = showOverlay(
      (context, progress) => Opacity(
        opacity: progress,
        child: DebugPopUp(
          onClicked: _alice.showInspector,
          callsSubscription: core.callsSubject.stream,
          aliceCore: core,
        ),
      ),
      context: context,
      duration: Duration.zero,
    );
  }
}
