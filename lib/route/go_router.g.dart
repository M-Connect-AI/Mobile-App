// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $loginRoute,
  $registerRoute,
  $homeRoute,
  $chatSettingsRoute,
  $leaveListRoute,
  $leaveDetailRoute,
  $tripListRoute,
  $tripDetailRoute,
  $outlookConnectionRoute,
  $outlookCalendarRoute,
  $outlookConflictRoute,
  $outlookMailListRoute,
  $outlookMailDetailRoute,
];

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: $LoginRoute._fromState);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute =>
    GoRouteData.$route(path: '/register', factory: $RegisterRoute._fromState);

mixin $RegisterRoute on GoRouteData {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  @override
  String get location => GoRouteData.$location('/register');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute =>
    GoRouteData.$route(path: '/home', factory: $HomeRoute._fromState);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chatSettingsRoute => GoRouteData.$route(
  path: '/chat-settings',
  factory: $ChatSettingsRoute._fromState,
);

mixin $ChatSettingsRoute on GoRouteData {
  static ChatSettingsRoute _fromState(GoRouterState state) =>
      const ChatSettingsRoute();

  @override
  String get location => GoRouteData.$location('/chat-settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $leaveListRoute =>
    GoRouteData.$route(path: '/leaves', factory: $LeaveListRoute._fromState);

mixin $LeaveListRoute on GoRouteData {
  static LeaveListRoute _fromState(GoRouterState state) =>
      const LeaveListRoute();

  @override
  String get location => GoRouteData.$location('/leaves');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $leaveDetailRoute => GoRouteData.$route(
  path: '/leaves/:id',
  factory: $LeaveDetailRoute._fromState,
);

mixin $LeaveDetailRoute on GoRouteData {
  static LeaveDetailRoute _fromState(GoRouterState state) => LeaveDetailRoute(
    state.pathParameters['id']!,
    $extra: state.extra as String?,
  );

  LeaveDetailRoute get _self => this as LeaveDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/leaves/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $tripListRoute =>
    GoRouteData.$route(path: '/trips', factory: $TripListRoute._fromState);

mixin $TripListRoute on GoRouteData {
  static TripListRoute _fromState(GoRouterState state) => const TripListRoute();

  @override
  String get location => GoRouteData.$location('/trips');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tripDetailRoute => GoRouteData.$route(
  path: '/trips/:id',
  factory: $TripDetailRoute._fromState,
);

mixin $TripDetailRoute on GoRouteData {
  static TripDetailRoute _fromState(GoRouterState state) => TripDetailRoute(
    state.pathParameters['id']!,
    $extra: state.extra as TripRequest?,
  );

  TripDetailRoute get _self => this as TripDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/trips/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $outlookConnectionRoute => GoRouteData.$route(
  path: '/outlook',
  factory: $OutlookConnectionRoute._fromState,
);

mixin $OutlookConnectionRoute on GoRouteData {
  static OutlookConnectionRoute _fromState(GoRouterState state) =>
      const OutlookConnectionRoute();

  @override
  String get location => GoRouteData.$location('/outlook');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $outlookCalendarRoute => GoRouteData.$route(
  path: '/outlook/calendar',
  factory: $OutlookCalendarRoute._fromState,
);

mixin $OutlookCalendarRoute on GoRouteData {
  static OutlookCalendarRoute _fromState(GoRouterState state) =>
      const OutlookCalendarRoute();

  @override
  String get location => GoRouteData.$location('/outlook/calendar');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $outlookConflictRoute => GoRouteData.$route(
  path: '/outlook/conflicts',
  factory: $OutlookConflictRoute._fromState,
);

mixin $OutlookConflictRoute on GoRouteData {
  static OutlookConflictRoute _fromState(GoRouterState state) =>
      const OutlookConflictRoute();

  @override
  String get location => GoRouteData.$location('/outlook/conflicts');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $outlookMailListRoute => GoRouteData.$route(
  path: '/outlook/mails',
  factory: $OutlookMailListRoute._fromState,
);

mixin $OutlookMailListRoute on GoRouteData {
  static OutlookMailListRoute _fromState(GoRouterState state) =>
      const OutlookMailListRoute();

  @override
  String get location => GoRouteData.$location('/outlook/mails');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $outlookMailDetailRoute => GoRouteData.$route(
  path: '/outlook/mail',
  factory: $OutlookMailDetailRoute._fromState,
);

mixin $OutlookMailDetailRoute on GoRouteData {
  static OutlookMailDetailRoute _fromState(GoRouterState state) =>
      OutlookMailDetailRoute(id: state.uri.queryParameters['id']!);

  OutlookMailDetailRoute get _self => this as OutlookMailDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/outlook/mail', queryParams: {'id': _self.id});

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
