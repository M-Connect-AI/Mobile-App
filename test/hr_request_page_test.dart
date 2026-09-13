import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/hr_request.dart';
import 'package:chatbot_project/domain/repository/hr_request_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/hr/bloc/hr_request_cubit.dart';
import 'package:chatbot_project/presentation/pages/hr/hr_request_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

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
      expect(find.text('03/09/2026'), findsOneWidget);

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
}

Widget _app({required ThemeData theme, required Widget page}) =>
    RepositoryProvider<HrRequestRepository>.value(
      value: const _FakeRepository(),
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          theme: theme,
          locale: const Locale('vi'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: page,
        ),
      ),
    );

class _FakeRepository implements HrRequestRepository {
  const _FakeRepository();

  @override
  Future<List<LeaveRequest>> getLeaves() async => [await getLeave('leave-1')];

  @override
  Future<LeaveRequest> getLeave(String id) async => LeaveRequest(
    id: id,
    employeeCode: 'EMP001',
    type: LeaveType.annual,
    from: DateTime(2026, 9, 3),
    to: DateTime(2026, 9, 5),
    days: 3,
    reason: 'Family event',
    status: RequestStatus.approved,
  );

  @override
  Future<List<TripRequest>> getTrips() async => [
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
}
