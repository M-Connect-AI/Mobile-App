import 'package:chatbot_project/common/components/irh_button.dart';
import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/auth_preference_repository.dart';
import 'package:chatbot_project/domain/repository/auth_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cho phép nhập thủ công và chọn role quản lý', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(create: (_) => _AuthRepository()),
          RepositoryProvider<CredentialRepository>(create: (_) => _Storage()),
          RepositoryProvider<AuthPreferenceRepository>(
            create: (_) => _Storage(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, child) => MaterialApp(
            theme: AppTheme.light,
            locale: const Locale('vi'),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const RegisterPage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('register-full-name-field')),
      'Nguyễn Văn A',
    );
    await tester.enterText(
      find.byKey(const Key('register-email-field')),
      'a@msb.vn',
    );
    await tester.enterText(
      find.byKey(const Key('register-password-field')),
      'pass123',
    );
    await tester.tap(find.byKey(const Key('register-role-manager')));
    await tester.pump();

    final managerChip = tester.widget<IrhOptionChip>(
      find.byKey(const Key('register-role-manager')),
    );
    expect(managerChip.selected, isTrue);
    expect(find.byKey(const Key('register-full-name-field')), findsOneWidget);
    expect(find.byKey(const Key('register-email-field')), findsOneWidget);
  });
}

class _AuthRepository implements AuthRepository {
  @override
  Future<AuthUser> getProfile(String accessToken) => throw UnimplementedError();

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) => throw UnimplementedError();

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) => throw UnimplementedError();
}

class _Storage implements CredentialRepository, AuthPreferenceRepository {
  @override
  Future<void> clear() async {}

  @override
  Future<AuthSession?> read() async => null;

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}

  @override
  Future<bool> readAutoLoginEnabled() async => false;

  @override
  Future<String?> readLastEmail() async => null;

  @override
  Future<void> saveLastEmail(String email) async {}

  @override
  Future<void> setAutoLoginEnabled(bool enabled) async {}
  @override
  Future<bool> readAliceBubbleEnabled() async => false;

  @override
  Future<void> setAliceBubbleEnabled(bool enabled) async {}
}
