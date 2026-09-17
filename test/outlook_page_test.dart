import 'package:chatbot_project/domain/model/outlook.dart';
import 'package:chatbot_project/domain/repository/outlook_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/outlook/outlook_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows connected Outlook account and read destinations', (
    tester,
  ) async {
    await tester.pumpWidget(
      const _TestApp(
        repository: _OutlookRepository(
          status: OutlookConnectionStatus(
            configured: true,
            connected: true,
            microsoftEmail: 'a@msb.vn',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(S.current.outlookConnected), findsOneWidget);
    expect(find.text('a@msb.vn'), findsOneWidget);
    expect(find.text(S.current.outlookCalendar), findsOneWidget);
    expect(find.text(S.current.outlookConflicts), findsOneWidget);
    expect(find.text(S.current.outlookMail), findsOneWidget);
    expect(find.text(S.current.outlookDisconnect), findsOneWidget);
  });

  testWidgets('shows connect action when Outlook is disconnected', (
    tester,
  ) async {
    await tester.pumpWidget(
      const _TestApp(
        repository: _OutlookRepository(
          status: OutlookConnectionStatus(configured: true, connected: false),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(S.current.outlookNotConnected), findsOneWidget);
    expect(find.text(S.current.outlookConnect), findsOneWidget);
    expect(find.text(S.current.outlookCheckConnection), findsOneWidget);
    expect(find.text(S.current.outlookOAuthReturnHint), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.repository});

  final OutlookRepository repository;

  @override
  Widget build(BuildContext context) =>
      RepositoryProvider<OutlookRepository>.value(
        value: repository,
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, child) => MaterialApp(
            locale: const Locale('vi'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const OutlookConnectionPage(),
          ),
        ),
      );
}

class _OutlookRepository implements OutlookRepository {
  const _OutlookRepository({required this.status});

  final OutlookConnectionStatus status;

  @override
  Future<void> disconnect() async {}

  @override
  Future<Uri> getAuthUri() async => Uri.parse('https://login.microsoft.com');

  @override
  Future<OutlookCalendarData> getCalendar({
    required String from,
    required String to,
  }) async => const OutlookCalendarData(microsoftEmail: 'a@msb.vn', events: []);

  @override
  Future<OutlookMail> getMail(String id) => throw UnimplementedError();

  @override
  Future<OutlookMailListData> getMails({
    bool unreadOnly = false,
    int top = 15,
    String? search,
    String? from,
    String? to,
  }) async => OutlookMailListData(
    microsoftEmail: 'a@msb.vn',
    mails: const [],
    unreadOnly: unreadOnly,
  );

  @override
  Future<OutlookCalendarData> getConflicts({
    required String from,
    required String to,
  }) async => const OutlookCalendarData(microsoftEmail: 'a@msb.vn', events: []);

  @override
  Future<OutlookConnectionStatus> getStatus() async => status;
}
