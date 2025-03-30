import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RootRoute.page),
        AutoRoute(page: EventRoute.page),
        AutoRoute(page: EventEditingRoute.page),
        AutoRoute(page: AuthRoute.page, initial: true),
        AutoRoute(page: VerificationRoute.page),
      ];
}
