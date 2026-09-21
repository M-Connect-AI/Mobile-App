import 'package:flutter/services.dart';

abstract final class AppSettingsLauncher {
  static const _channel = MethodChannel('com.irohasu.mconnect/app_settings');

  static Future<bool> open() async {
    try {
      return await _channel.invokeMethod<bool>('open') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }
}
