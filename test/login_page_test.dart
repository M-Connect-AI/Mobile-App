import 'package:chatbot_project/common/navigation/external_action_handler.dart';
import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/common/server_config/server_config_scope.dart';
import 'package:chatbot_project/data/repository/pending_action_store.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/pending_action.dart';
import 'package:chatbot_project/domain/model/server_config.dart';
import 'package:chatbot_project/domain/repository/auth_repository.dart';
import 'package:chatbot_project/domain/repository/auth_preference_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/repository/home_repository.dart';
import 'package:chatbot_project/domain/repository/server_config_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('server config opens and login flow reaches home', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final auth = _SuccessfulAuthRepository();
    final authPreferences = _MemoryAuthPreferenceRepository(lastEmail: 'previous@msb.vn');
    final serverConfig = _MemoryServerConfigRepository();
    final externalActions = ExternalActionHandler(
      credentials: _MemoryCredentialRepository(),
      auth: auth,
      pending: _EmptyPendingActionStore(),
    );
    final router = GoRouter(initialLocation: const LoginRoute().location, routes: appRoutes);
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ServerConfigScope(
        apply: serverConfig.save,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>(create: (_) => auth),
            RepositoryProvider<CredentialRepository>(create: (_) => _MemoryCredentialRepository()),
            RepositoryProvider<AuthPreferenceRepository>(create: (_) => authPreferences),
            RepositoryProvider<HomeRepository>(create: (_) => const _LoginHomeRepository()),
            RepositoryProvider<ServerConfigRepository>.value(value: serverConfig),
            RepositoryProvider<ExternalActionHandler>.value(value: externalActions),
          ],
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp.router(
              routerConfig: router,
              theme: AppTheme.light,
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
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Đăng nhập'), findsNWidgets(2));
    final emailInput = tester.widget<EditableText>(
      find.descendant(
        of: find.byKey(const Key('login-email-field')),
        matching: find.byType(EditableText),
      ),
    );
    expect(emailInput.controller.text, 'previous@msb.vn');
    expect(find.byKey(const Key('login-logo')), findsOneWidget);
    expect(tester.getTopLeft(find.byKey(const Key('login-logo'))).dx, 55);
    expect(
      tester.getBottomLeft(find.byKey(const Key('login-logo'))).dy,
      lessThanOrEqualTo(tester.getTopLeft(find.byKey(const Key('login-form-card'))).dy),
    );
    expect(find.text('© MSB 2023 ALL RIGHT RESERVED'), findsOneWidget);
    expect(find.byKey(const Key('server-config-button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('server-config-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('server-config-dialog')), findsOneWidget);
    await tester.tap(find.text(S.current.cancelButton));
    await tester.pumpAndSettle();
    expect(find.text('Đăng nhập mô phỏng · Chưa kết nối API thật'), findsNothing);

    expect(find.text('Tài khoản gợi ý'), findsNothing);
    await tester.enterText(find.byKey(const Key('login-email-field')), 'a.nguyen@msb.vn');
    await tester.enterText(find.byKey(const Key('login-password-field')), 'password123');
    final loginButton = find.byKey(const Key('login-button'));
    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(auth.email, 'a.nguyen@msb.vn');
    expect(find.text(S.current.homeGreetingName('Minh')), findsOneWidget);
  });
}

class _MemoryAuthPreferenceRepository implements AuthPreferenceRepository {
  _MemoryAuthPreferenceRepository({this.lastEmail});

  final String? lastEmail;

  @override
  Future<bool> readAutoLoginEnabled() async => false;

  @override
  Future<String?> readLastEmail() async => lastEmail;

  @override
  Future<void> saveLastEmail(String email) async {}

  @override
  Future<void> setAutoLoginEnabled(bool enabled) async {}
  @override
  Future<bool> readAliceBubbleEnabled() async => false;

  @override
  Future<void> setAliceBubbleEnabled(bool enabled) async {}
}

class _SuccessfulAuthRepository implements AuthRepository {
  String? email;

  @override
  Future<AuthUser> getProfile(String accessToken) async => _session.user;

  @override
  Future<AuthSession> login({required String email, required String password}) async {
    this.email = email;
    return _session;
  }

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async => _session;
}

class _EmptyPendingActionStore extends PendingActionStore {
  @override
  Future<void> save(PendingAction action) async {}

  @override
  Future<PendingAction?> peek() async => null;

  @override
  Future<PendingAction?> consume() async => null;

  @override
  Future<void> clear() async {}
}

class _MemoryCredentialRepository implements CredentialRepository {
  AuthSession? session;

  @override
  Future<void> clear() async => session = null;

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession value, {required bool persist}) async => session = value;
}

class _MemoryServerConfigRepository implements ServerConfigRepository {
  @override
  final ServerConfig defaults = const ServerConfig(
    hrApiBaseUrl: 'http://localhost:3002',
    agentApiBaseUrl: 'http://localhost:3001',
  );

  ServerConfig? current;

  @override
  Future<ServerConfig> read() async => current ?? defaults;

  @override
  Future<void> save(ServerConfig config) async => current = config;

  @override
  Future<void> clear() async => current = null;
}

class _LoginHomeRepository implements HomeRepository {
  const _LoginHomeRepository();

  @override
  Future<HomeData> getHomeData() async => const HomeData(
    user: AuthUser(
      id: 'user-id',
      employeeCode: 'EMP001',
      email: 'a.nguyen@msb.vn',
      fullName: 'Minh',
      role: UserRole.staff,
      department: 'Khối bán lẻ',
      annualRemaining: 9,
      annualTotal: 12,
      sickRemaining: 30,
    ),
    leaveBalance: LeaveBalance(
      employeeCode: 'EMP001',
      annualRemaining: 9,
      annualTotal: 12,
      sickRemaining: 30,
    ),
    upcomingTrips: [],
  );
}

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'user-id',
    employeeCode: 'EMP001',
    email: 'a.nguyen@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: UserRole.staff,
    department: 'Khối bán lẻ',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
