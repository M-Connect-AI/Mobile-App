import '../model/outlook.dart';

enum OutlookFailureType {
  sessionExpired,
  notConfigured,
  notConnected,
  permissionDenied,
  network,
  server,
  invalidResponse,
  business,
}

class OutlookException implements Exception {
  const OutlookException(this.type, {this.message});

  final OutlookFailureType type;
  final String? message;
}

abstract interface class OutlookRepository {
  Future<OutlookConnectionStatus> getStatus();

  Future<Uri> getAuthUri();

  Future<void> disconnect();

  Future<OutlookCalendarData> getCalendar({
    required String from,
    required String to,
  });

  Future<OutlookCalendarData> getConflicts({
    required String from,
    required String to,
  });

  Future<OutlookMailListData> getMails({
    bool unreadOnly = false,
    int top = 15,
    String? search,
    String? from,
    String? to,
  });

  Future<OutlookMail> getMail(String id);
}
