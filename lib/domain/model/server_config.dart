import 'package:flutter/foundation.dart';

@immutable
class ServerConfig {
  const ServerConfig({
    required this.hrApiBaseUrl,
    required this.agentApiBaseUrl,
  });

  final String hrApiBaseUrl;
  final String agentApiBaseUrl;

  ServerConfig normalized() => ServerConfig(
    hrApiBaseUrl: _normalizeUrl(hrApiBaseUrl),
    agentApiBaseUrl: _normalizeUrl(agentApiBaseUrl),
  );

  static String _normalizeUrl(String value) =>
      value.trim().replaceFirst(RegExp(r'/+$'), '');
}
