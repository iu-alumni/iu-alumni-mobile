import 'package:auto_route/auto_route.dart';
import 'config.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RootRoute.page, initial: true),
        AutoRoute(page: EventRoute.page),
        AutoRoute(page: EventEditingRoute.page),
      ];
}
