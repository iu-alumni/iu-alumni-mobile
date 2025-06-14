import 'package:flutter/widgets.dart';

class AlwaysRootRouteInformationProvider extends RouteInformationProvider
    with ChangeNotifier {
  final RouteInformation _value = RouteInformation(
    uri: Uri.parse('/'),
  );

  @override
  RouteInformation get value => _value;

  @override
  void routerReportsNewRouteInformation(
    RouteInformation routeInformation, {
    RouteInformationReportingType type = RouteInformationReportingType.none,
  }) {}
}
