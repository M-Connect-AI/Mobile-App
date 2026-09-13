import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_alice/alice.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../common/navigation/root_navigator_key.dart';

abstract final class DioClientFactory {
  static final Alice _alice = Alice(
    navigatorKey: rootNavigatorKey,
    showNotification: true,
  );

  static Dio create() {
    final dio = Dio();
    if (!kDebugMode) return dio;

    dio.interceptors.addAll([
      _alice.getDioInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    ]);
    return dio;
  }

  static void showInspector() => _alice.showInspector();
}
