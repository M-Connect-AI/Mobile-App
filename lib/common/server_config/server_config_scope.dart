import 'package:flutter/widgets.dart';

import '../../domain/model/server_config.dart';

typedef ApplyServerConfig = Future<void> Function(ServerConfig config);

class ServerConfigScope extends InheritedWidget {
  const ServerConfigScope({
    super.key,
    required this.apply,
    required super.child,
  });

  final ApplyServerConfig apply;

  static ServerConfigScope of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<ServerConfigScope>();
    assert(
      scope != null,
      'ServerConfigScope was not found in the widget tree.',
    );
    return scope!;
  }

  @override
  bool updateShouldNotify(ServerConfigScope oldWidget) =>
      apply != oldWidget.apply;
}
