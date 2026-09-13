// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $loginRoute,
  $homeRoute,
  $leaveListRoute,
  $leaveDetailRoute,
  $tripListRoute,
  $tripDetailRoute,
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
  static LeaveDetailRoute _fromState(GoRouterState state) =>
      LeaveDetailRoute(state.pathParameters['id']!);

  LeaveDetailRoute get _self => this as LeaveDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/leaves/${Uri.encodeComponent(_self.id)}');

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
  static TripDetailRoute _fromState(GoRouterState state) =>
      TripDetailRoute(state.pathParameters['id']!);

  TripDetailRoute get _self => this as TripDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/trips/${Uri.encodeComponent(_self.id)}');

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
