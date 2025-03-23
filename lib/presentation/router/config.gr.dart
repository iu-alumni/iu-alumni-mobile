// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i7;
import 'package:fpdart/fpdart.dart' as _i6;
import 'package:ui_alumni_mobile/presentation/pages/auth/auth_page.dart' as _i1;
import 'package:ui_alumni_mobile/presentation/pages/event/event_page.dart'
    as _i3;
import 'package:ui_alumni_mobile/presentation/pages/event_editing/event_editing_page.dart'
    as _i2;
import 'package:ui_alumni_mobile/presentation/pages/root/root_page.dart' as _i4;

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i5.PageRouteInfo<void> {
  const AuthRoute({List<_i5.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i1.AuthPage());
    },
  );
}

/// generated route for
/// [_i2.EventEditingPage]
class EventEditingRoute extends _i5.PageRouteInfo<EventEditingRouteArgs> {
  EventEditingRoute({
    required _i6.Option<String> eventId,
    _i7.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         EventEditingRoute.name,
         args: EventEditingRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventEditingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventEditingRouteArgs>();
      return _i5.WrappedRoute(
        child: _i2.EventEditingPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventEditingRouteArgs {
  const EventEditingRouteArgs({required this.eventId, this.key});

  final _i6.Option<String> eventId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'EventEditingRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i3.EventPage]
class EventRoute extends _i5.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required String eventId,
    _i7.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         EventRoute.name,
         args: EventRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return _i5.WrappedRoute(
        child: _i3.EventPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final String eventId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i4.RootPage]
class RootRoute extends _i5.PageRouteInfo<void> {
  const RootRoute({List<_i5.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i4.RootPage());
    },
  );
}
