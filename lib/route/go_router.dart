import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../common/navigation/root_navigator_key.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/speech_to_text_repository.dart';
import '../domain/service/data_refresh_coordinator.dart';
import '../domain/service/device_calendar_service.dart';
import '../domain/model/chat_result.dart';
import '../presentation/pages/chat/bloc/chat_bloc.dart';
import '../presentation/pages/chat/chat_page.dart';
import '../presentation/pages/home/chat_history_page.dart';
import '../presentation/pages/home/home_chat_ai_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/login/login_page.dart';
import '../presentation/pages/login/register_page.dart';
import '../presentation/pages/hr/bloc/hr_request_cubit.dart';
import '../presentation/pages/hr/hr_request_pages.dart';
import '../presentation/pages/jira/jira_pages.dart';
import '../presentation/pages/outlook/outlook_pages.dart';

part 'go_router.g.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: const LoginRoute().location,
  routes: appRoutes,
);

final List<RouteBase> appRoutes = [
  ...$appRoutes,
  GoRoute(
    path: HomeChatAiRoute.path,
    builder: (context, state) => const HomeChatAiPage(),
  ),
  GoRoute(
    path: ChatHistoryRoute.path,
    builder: (context, state) => const ChatHistoryPage(),
  ),
  GoRoute(
    path: JiraTaskOverviewRoute.path,
    redirect: (context, state) =>
        state.extra is JiraIssueList ? null : const HomeRoute().location,
    builder: (context, state) => JiraTaskOverviewRoute(
      state.extra as JiraIssueList,
    ).build(context, state),
  ),
  GoRoute(
    path: JiraTaskDetailRoute.path,
    redirect: (context, state) =>
        state.extra is JiraIssue ? null : const HomeRoute().location,
    builder: (context, state) =>
        JiraTaskDetailRoute(state.extra as JiraIssue).build(context, state),
  ),
  GoRoute(
    path: ChatRoute.path,
    pageBuilder: (context, state) => ChatRoute(
      threadId: state.uri.queryParameters['threadId'],
      title: state.uri.queryParameters['title'],
      initialMessage: state.uri.queryParameters['initialMessage'],
      autoSendInitialMessage:
          state.uri.queryParameters['autoSendInitialMessage'] == 'true',
      startRecording: state.uri.queryParameters['startRecording'] == 'true',
    ).buildPage(context, state),
  ),
];

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegisterPage();
}

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

@TypedGoRoute<LeaveListRoute>(path: '/leaves')
class LeaveListRoute extends GoRouteData with $LeaveListRoute {
  const LeaveListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HrRequestListPage(kind: HrRequestKind.leave);
}

@TypedGoRoute<LeaveDetailRoute>(path: '/leaves/:id')
class LeaveDetailRoute extends GoRouteData with $LeaveDetailRoute {
  const LeaveDetailRoute(this.id);

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HrRequestDetailPage(kind: HrRequestKind.leave, id: id);
}

@TypedGoRoute<TripListRoute>(path: '/trips')
class TripListRoute extends GoRouteData with $TripListRoute {
  const TripListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HrRequestListPage(kind: HrRequestKind.trip);
}

@TypedGoRoute<TripDetailRoute>(path: '/trips/:id')
class TripDetailRoute extends GoRouteData with $TripDetailRoute {
  const TripDetailRoute(this.id);

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HrRequestDetailPage(kind: HrRequestKind.trip, id: id);
}

@TypedGoRoute<OutlookConnectionRoute>(path: '/outlook')
class OutlookConnectionRoute extends GoRouteData with $OutlookConnectionRoute {
  const OutlookConnectionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OutlookConnectionPage();
}

@TypedGoRoute<OutlookCalendarRoute>(path: '/outlook/calendar')
class OutlookCalendarRoute extends GoRouteData with $OutlookCalendarRoute {
  const OutlookCalendarRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OutlookCalendarPage();
}

@TypedGoRoute<OutlookConflictRoute>(path: '/outlook/conflicts')
class OutlookConflictRoute extends GoRouteData with $OutlookConflictRoute {
  const OutlookConflictRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OutlookConflictPage();
}

@TypedGoRoute<OutlookMailListRoute>(path: '/outlook/mails')
class OutlookMailListRoute extends GoRouteData with $OutlookMailListRoute {
  const OutlookMailListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OutlookMailListPage();
}

@TypedGoRoute<OutlookMailDetailRoute>(path: '/outlook/mail')
class OutlookMailDetailRoute extends GoRouteData with $OutlookMailDetailRoute {
  const OutlookMailDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OutlookMailDetailPage(id: id);
}

class HomeChatAiRoute extends GoRouteData {
  const HomeChatAiRoute();

  static const path = '/ai';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomeChatAiPage();

  Future<T?> push<T>(BuildContext context) => context.push<T>(path);
}

class ChatHistoryRoute extends GoRouteData {
  const ChatHistoryRoute();

  static const path = '/ai/history';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChatHistoryPage();

  Future<T?> push<T>(BuildContext context) => context.push<T>(path);
}

class JiraTaskOverviewRoute extends GoRouteData {
  const JiraTaskOverviewRoute(this.data);

  static const path = '/jira/tasks';
  final JiraIssueList data;

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(path, extra: data);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      JiraTaskOverviewPage(
        data: data,
        calendarService: context.read<DeviceCalendarService>(),
      );
}

class JiraTaskDetailRoute extends GoRouteData {
  const JiraTaskDetailRoute(this.issue);

  static const path = '/jira/task';
  final JiraIssue issue;

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(path, extra: issue);

  @override
  Widget build(BuildContext context, GoRouterState state) => JiraTaskDetailPage(
    issue: issue,
    calendarService: context.read<DeviceCalendarService>(),
  );
}

class ChatRoute extends GoRouteData {
  const ChatRoute({
    this.threadId,
    this.title,
    this.initialMessage,
    this.autoSendInitialMessage = false,
    this.startRecording = false,
  });

  static const path = '/chat';

  final String? threadId;
  final String? title;
  final String? initialMessage;
  final bool autoSendInitialMessage;
  final bool startRecording;

  Future<T?> push<T>(BuildContext context) {
    final uri = Uri(
      path: path,
      queryParameters: {
        if (threadId != null) 'threadId': threadId,
        if (title?.trim().isNotEmpty == true) 'title': title!.trim(),
        if (initialMessage != null) 'initialMessage': initialMessage,
        if (autoSendInitialMessage) 'autoSendInitialMessage': 'true',
        if (startRecording) 'startRecording': 'true',
      },
    );
    return context.push<T>(uri.toString());
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 360),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      child: BlocProvider(
        create: (context) =>
            ChatBloc(
              context.read<ChatRepository>(),
              context.read<SpeechToTextRepository>(),
              refreshCoordinator: context.read<DataRefreshCoordinator?>(),
            )..add(
              ChatStarted(
                threadId: threadId,
                initialMessage: initialMessage,
                autoSendInitialMessage: autoSendInitialMessage,
                startRecording: startRecording,
              ),
            ),
        child: ChatPage(
          title: title,
          showCloseButton: true,
          autofocusInput:
              threadId == null && !autoSendInitialMessage && !startRecording,
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, .035),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          ),
        );
      },
    );
  }
}
