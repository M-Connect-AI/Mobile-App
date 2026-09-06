import '../model/home_data.dart';

abstract interface class HomeRepository {
  Future<HomeData> getHomeData();
}

enum HomeFailureType {
  sessionExpired,
  permissionDenied,
  network,
  server,
  invalidResponse,
}

class HomeException implements Exception {
  const HomeException({required this.type, required this.message});

  final HomeFailureType type;
  final String message;
}
