import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/model/hr_request.dart';
import 'package:chatbot_project/domain/repository/hr_request_repository.dart';
import 'package:chatbot_project/domain/service/data_refresh_coordinator.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/hr/bloc/hr_request_cubit.dart';
import 'package:chatbot_project/presentation/pages/hr/hr_request_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  for (final theme in [AppTheme.light, AppTheme.dark]) {
    testWidgets('renders leave and trip details in ${theme.brightness}', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _app(
          theme: theme,
          page: const HrRequestDetailPage(
            key: ValueKey('leave'),
            kind: HrRequestKind.leave,
            id: 'leave-1',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Family event'), findsOneWidget);
      expect(find.text('03/09/2026 → 05/09/2026 · 3 ngày'), findsOneWidget);

      await tester.pumpWidget(
        _app(
          theme: theme,
          page: const HrRequestDetailPage(
            key: ValueKey('trip'),
            kind: HrRequestKind.trip,
            id: 'trip-1',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ha Noi'), findsOneWidget);
      expect(find.text('Visit project partner'), findsOneWidget);
    });
  }

  testWidgets('manager sees pending actions and badge updates after approval', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final repository = _FakeRepository(pending: true);
    await tester.pumpWidget(
      _app(
        theme: AppTheme.light,
        page: const HrRequestDetailPage(
          kind: HrRequestKind.leave,
          id: 'leave-1',
        ),
        repository: repository,
        manager: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Duyệt đơn'), findsOneWidget);
    expect(find.text('Từ chối'), findsOneWidget);
    await tester.tap(find.text('Duyệt đơn'));
    await tester.pumpAndSettle();
    expect(find.text('Duyệt đơn nghỉ phép?'), findsOneWidget);
    await tester.tap(find.text('Duyệt đơn').last);
    await tester.pumpAndSettle();
    expect(repository.status, RequestStatus.approved);
    expect(find.text('Đã duyệt'), findsOneWidget);
    expect(find.text('Duyệt đơn'), findsNothing);
  });

  testWidgets('staff does not see actions on pending leave', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      _app(
        theme: AppTheme.light,
        page: const HrRequestDetailPage(
          kind: HrRequestKind.leave,
          id: 'leave-1',
        ),
        repository: _FakeRepository(pending: true),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Chờ duyệt'), findsOneWidget);
    expect(find.text('Duyệt đơn'), findsNothing);
    expect(find.text('Từ chối'), findsNothing);
  });
}

Widget _app({
  required ThemeData theme,
  required Widget page,
  _FakeRepository? repository,
  bool manager = false,
}) => MultiRepositoryProvider(
  providers: [
    RepositoryProvider<HrRequestRepository>.value(
      value: repository ?? _FakeRepository(),
    ),
    RepositoryProvider<CredentialRepository>.value(
      value: _Credentials(manager: manager),
    ),
    RepositoryProvider<DataRefreshCoordinator>(
      create: (_) => DataRefreshCoordinator(),
    ),
  ],
  child: ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, child) => MaterialApp.router(
      theme: theme,
      routerConfig: GoRouter(
        routes: [GoRoute(path: '/', builder: (context, state) => page)],
      ),
      locale: const Locale('vi'),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    ),
  ),
);

class _FakeRepository implements HrRequestRepository {
  _FakeRepository({this.pending = false});
  final bool pending;
  RequestStatus? status;

  @override
  Future<List<LeaveRequest>> getLeaves({bool team = false}) async => [
    await getLeave('leave-1'),
  ];

  @override
  Future<LeaveRequest> getLeave(String id) async => LeaveRequest(
    id: id,
    employeeCode: 'EMP001',
    type: LeaveType.annual,
    from: DateTime(2026, 9, 3),
    to: DateTime(2026, 9, 5),
    days: 3,
    reason: 'Family event',
    status:
        status ?? (pending ? RequestStatus.pending : RequestStatus.approved),
  );

  @override
  Future<List<TripRequest>> getTrips({bool team = false}) async => [
    TripRequest(
      id: 'trip-1',
      employeeCode: 'EMP001',
      destination: 'Ha Noi',
      from: DateTime(2026, 9, 8),
      to: DateTime(2026, 9, 10),
      purpose: 'Visit project partner',
      status: RequestStatus.pending,
    ),
  ];

  @override
  Future<LeaveRequest> setLeaveStatus(String id, RequestStatus status) async {
    this.status = status;
    return getLeave(id);
  }

  @override
  Future<TripRequest> setTripStatus(String id, RequestStatus status) async =>
      (await getTrips()).single.copyWith(status: status);
  @override
  Future<void> approveLeaves(List<String> ids) async {}
}

class _Credentials implements CredentialRepository {
  _Credentials({this.manager = false});
  final bool manager;
  @override
  Future<AuthSession?> read() async => AuthSession(
    accessToken: 'jwt',
    user: AuthUser(
      id: '1',
      employeeCode: 'EMP001',
      email: 'a@b.com',
      fullName: 'A',
      role: manager ? UserRole.manager : UserRole.staff,
      department: 'HR',
      annualRemaining: 1,
      annualTotal: 1,
      sickRemaining: 1,
    ),
  );
  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}
  @override
  Future<void> clear() async {}
}
