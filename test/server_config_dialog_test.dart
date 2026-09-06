import 'package:chatbot_project/common/server_config/server_config_scope.dart';
import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/domain/model/server_config.dart';
import 'package:chatbot_project/domain/repository/server_config_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/server_config/server_config_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('edits, normalizes, and applies server configuration', (
    tester,
  ) async {
    final repository = _MemoryServerConfigRepository();
    ServerConfig? applied;

    await tester.pumpWidget(
      RepositoryProvider<ServerConfigRepository>.value(
        value: repository,
        child: ServerConfigScope(
          apply: (config) async {
            await repository.save(config);
            applied = config;
          },
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
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
              home: const Scaffold(body: ServerConfigButton()),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('server-config-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('server-config-dialog')), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('hr-api-url-field')),
      'https://hr.example.com/',
    );
    await tester.enterText(
      find.byKey(const Key('agent-api-url-field')),
      'https://agent.example.com///',
    );
    await tester.tap(find.byKey(const Key('save-server-config-button')));
    await tester.pumpAndSettle();

    expect(applied?.hrApiBaseUrl, 'https://hr.example.com');
    expect(applied?.agentApiBaseUrl, 'https://agent.example.com');
    expect((await repository.read()).agentApiBaseUrl, applied?.agentApiBaseUrl);
  });

  testWidgets('rejects an invalid server URL and restores defaults', (
    tester,
  ) async {
    final repository = _MemoryServerConfigRepository();

    await tester.pumpWidget(
      RepositoryProvider<ServerConfigRepository>.value(
        value: repository,
        child: ServerConfigScope(
          apply: repository.save,
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
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
              home: const Scaffold(body: ServerConfigButton()),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('server-config-button')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('hr-api-url-field')),
      'not-a-url',
    );
    await tester.tap(find.byKey(const Key('save-server-config-button')));
    await tester.pump();

    expect(
      find.text('Nhập URL đầy đủ bắt đầu bằng http:// hoặc https://'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('restore-server-defaults-button')));
    await tester.pump();
    expect(
      tester
          .widget<TextFormField>(find.byKey(const Key('hr-api-url-field')))
          .controller
          ?.text,
      repository.defaults.hrApiBaseUrl,
    );
  });
}

class _MemoryServerConfigRepository implements ServerConfigRepository {
  @override
  final ServerConfig defaults = const ServerConfig(
    hrApiBaseUrl: 'http://localhost:3002',
    agentApiBaseUrl: 'http://localhost:3001',
  );

  ServerConfig? currentOverride;

  @override
  Future<void> clear() async => currentOverride = null;

  @override
  Future<ServerConfig> read() async => currentOverride ?? defaults;

  @override
  Future<void> save(ServerConfig config) async =>
      currentOverride = config.normalized();
}
