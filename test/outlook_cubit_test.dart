import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/model/outlook.dart';
import 'package:chatbot_project/domain/repository/outlook_repository.dart';
import 'package:chatbot_project/domain/service/data_refresh_coordinator.dart';
import 'package:chatbot_project/presentation/pages/outlook/bloc/outlook_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads connection status and exposes a typed failure', () async {
    final repository = _OutlookRepository();
    final cubit = OutlookCubit(repository);
    addTearDown(cubit.close);

    await cubit.loadStatus();

    expect(cubit.state.status, OutlookLoadStatus.success);
    expect(cubit.state.connection?.connected, isTrue);

    repository.statusError = const OutlookException(
      OutlookFailureType.sessionExpired,
      message: 'expired',
    );
    await cubit.loadStatus();

    expect(cubit.state.status, OutlookLoadStatus.failure);
    expect(cubit.state.failure, OutlookFailureType.sessionExpired);
    expect(cubit.state.failureMessage, 'expired');
  });

  test('reloads the active Outlook view after a scoped refresh', () async {
    final repository = _OutlookRepository();
    final coordinator = DataRefreshCoordinator();
    final cubit = OutlookCubit(repository, refreshCoordinator: coordinator);
    addTearDown(cubit.close);
    addTearDown(coordinator.close);

    await cubit.loadMails(unreadOnly: true, search: 'budget');
    expect(repository.mailRequests, 1);

    coordinator.notify(const {DataRefreshScope.home});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    expect(repository.mailRequests, 1);

    coordinator.notify(const {DataRefreshScope.outlook});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(repository.mailRequests, 2);
    expect(repository.lastUnreadOnly, isTrue);
    expect(repository.lastSearch, 'budget');
  });
}

class _OutlookRepository implements OutlookRepository {
  OutlookException? statusError;
  int mailRequests = 0;
  bool? lastUnreadOnly;
  String? lastSearch;

  @override
  Future<OutlookConnectionStatus> getStatus() async {
    final error = statusError;
    if (error != null) throw error;
    return const OutlookConnectionStatus(
      configured: true,
      connected: true,
      microsoftEmail: 'a@msb.vn',
    );
  }

  @override
  Future<OutlookMailListData> getMails({
    bool unreadOnly = false,
    int top = 15,
    String? search,
    String? from,
    String? to,
  }) async {
    mailRequests += 1;
    lastUnreadOnly = unreadOnly;
    lastSearch = search;
    return OutlookMailListData(
      microsoftEmail: 'a@msb.vn',
      mails: const [],
      unreadOnly: unreadOnly,
      from: from,
      to: to,
    );
  }

  @override
  Future<Uri> getAuthUri() => throw UnimplementedError();

  @override
  Future<void> disconnect() => throw UnimplementedError();

  @override
  Future<OutlookCalendarData> getCalendar({
    required String from,
    required String to,
  }) => throw UnimplementedError();

  @override
  Future<OutlookCalendarData> getConflicts({
    required String from,
    required String to,
  }) => throw UnimplementedError();

  @override
  Future<OutlookMail> getMail(String id) => throw UnimplementedError();
}
