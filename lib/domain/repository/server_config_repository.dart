import '../model/server_config.dart';

abstract interface class ServerConfigRepository {
  ServerConfig get defaults;

  Future<ServerConfig> read();

  Future<void> save(ServerConfig config);

  Future<void> clear();
}
