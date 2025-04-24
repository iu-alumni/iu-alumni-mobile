import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../application/repositories/reporter/reporter.dart';

class AppObserver extends AutoRouteObserver {
  AppObserver(this._reporter);

  final Reporter _reporter;

  @override
  void didPush(Route route, Route? previousRoute) => _reporter.reportNavigation(
        NavAction.push,
        previousRoute?.name,
        route.name,
      );

  @override
  void didPop(Route route, Route? previousRoute) => _reporter.reportNavigation(
        NavAction.pop,
        previousRoute?.name,
        route.name,
      );

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) =>
      _reporter.reportNavigation(
        NavAction.replace,
        oldRoute?.name,
        newRoute?.name,
      );
}

extension on Route {
  String? get name => settings.name;
}
