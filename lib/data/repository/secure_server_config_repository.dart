import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/model/server_config.dart';
import '../../domain/repository/server_config_repository.dart';

class SecureServerConfigRepository implements ServerConfigRepository {
  SecureServerConfigRepository({
    required this.defaults,
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  static const _hrApiBaseUrlKey = 'server_config_hr_api_base_url';
  static const _agentApiBaseUrlKey = 'server_config_agent_api_base_url';

  @override
  final ServerConfig defaults;

  final FlutterSecureStorage _storage;

  @override
  Future<ServerConfig> read() async {
    final values = await Future.wait([
      _storage.read(key: _hrApiBaseUrlKey),
      _storage.read(key: _agentApiBaseUrlKey),
    ]);
    return ServerConfig(
      hrApiBaseUrl: values[0] ?? defaults.hrApiBaseUrl,
      agentApiBaseUrl: values[1] ?? defaults.agentApiBaseUrl,
    ).normalized();
  }

  @override
  Future<void> save(ServerConfig config) async {
    final normalized = config.normalized();
    await Future.wait([
      _storage.write(key: _hrApiBaseUrlKey, value: normalized.hrApiBaseUrl),
      _storage.write(
        key: _agentApiBaseUrlKey,
        value: normalized.agentApiBaseUrl,
      ),
    ]);
  }

  @override
  Future<void> clear() async {
    await Future.wait([
      _storage.delete(key: _hrApiBaseUrlKey),
      _storage.delete(key: _agentApiBaseUrlKey),
    ]);
  }
}
