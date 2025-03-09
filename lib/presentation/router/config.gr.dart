// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:ui_alumni_mobile/presentation/pages/event/event_page.dart'
    as _i1;
import 'package:ui_alumni_mobile/presentation/pages/root/root_page.dart' as _i2;

/// generated route for
/// [_i1.EventPage]
class EventRoute extends _i3.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required String eventId,
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         EventRoute.name,
         args: EventRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return _i1.EventPage(eventId: args.eventId, key: args.key);
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final String eventId;

  final _i4.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i2.RootPage]
class RootRoute extends _i3.PageRouteInfo<void> {
  const RootRoute({List<_i3.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.RootPage();
    },
  );
}
