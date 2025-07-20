import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: RootRoute.page),
    AutoRoute(page: EventRoute.page),
    AutoRoute(page: EventEditingRoute.page),
    AutoRoute(
      page: AuthRoute.page,
      children: [
        AutoRoute(page: SignInSubRoute.page, initial: true),
        AutoRoute(page: RegistrationSubRoute.page),
        AutoRoute(page: CodeVerificationSubRoute.page),
        AutoRoute(page: RestoredVerificationSubRoute.page),
        AutoRoute(page: VerificationWaySubRoute.page),
      ],
    ),
    AutoRoute(page: ProfileEditingRoute.page),
    AutoRoute(page: AppLoadingRoute.page, initial: true),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: CityDataRoute.page),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
}
