// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i9;
import 'package:fpdart/fpdart.dart' as _i8;
import 'package:ui_alumni_mobile/presentation/pages/auth/auth_page.dart' as _i1;
import 'package:ui_alumni_mobile/presentation/pages/event/event_page.dart'
    as _i3;
import 'package:ui_alumni_mobile/presentation/pages/event_editing/event_editing_page.dart'
    as _i2;
import 'package:ui_alumni_mobile/presentation/pages/profile_editing/profile_editing_page.dart'
    as _i4;
import 'package:ui_alumni_mobile/presentation/pages/root/root_page.dart' as _i5;
import 'package:ui_alumni_mobile/presentation/pages/verification/verification_page.dart'
    as _i6;

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i7.PageRouteInfo<void> {
  const AuthRoute({List<_i7.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i1.AuthPage());
    },
  );
}

/// generated route for
/// [_i2.EventEditingPage]
class EventEditingRoute extends _i7.PageRouteInfo<EventEditingRouteArgs> {
  EventEditingRoute({
    required _i8.Option<String> eventId,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         EventEditingRoute.name,
         args: EventEditingRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventEditingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventEditingRouteArgs>();
      return _i7.WrappedRoute(
        child: _i2.EventEditingPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventEditingRouteArgs {
  const EventEditingRouteArgs({required this.eventId, this.key});

  final _i8.Option<String> eventId;

  final _i9.Key? key;

  @override
  String toString() {
    return 'EventEditingRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i3.EventPage]
class EventRoute extends _i7.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required String eventId,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         EventRoute.name,
         args: EventRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return _i7.WrappedRoute(
        child: _i3.EventPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final String eventId;

  final _i9.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i4.ProfileEditingPage]
class ProfileEditingRoute extends _i7.PageRouteInfo<void> {
  const ProfileEditingRoute({List<_i7.PageRouteInfo>? children})
    : super(ProfileEditingRoute.name, initialChildren: children);

  static const String name = 'ProfileEditingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i4.ProfileEditingPage());
    },
  );
}

/// generated route for
/// [_i5.RootPage]
class RootRoute extends _i7.PageRouteInfo<void> {
  const RootRoute({List<_i7.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i5.RootPage());
    },
  );
}

/// generated route for
/// [_i6.VerificationPage]
class VerificationRoute extends _i7.PageRouteInfo<VerificationRouteArgs> {
  VerificationRoute({
    required String initialEmail,
    required String? initialPassword,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         VerificationRoute.name,
         args: VerificationRouteArgs(
           initialEmail: initialEmail,
           initialPassword: initialPassword,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'VerificationRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerificationRouteArgs>();
      return _i7.WrappedRoute(
        child: _i6.VerificationPage(
          initialEmail: args.initialEmail,
          initialPassword: args.initialPassword,
          key: args.key,
        ),
      );
    },
  );
}

class VerificationRouteArgs {
  const VerificationRouteArgs({
    required this.initialEmail,
    required this.initialPassword,
    this.key,
  });

  final String initialEmail;

  final String? initialPassword;

  final _i9.Key? key;

  @override
  String toString() {
    return 'VerificationRouteArgs{initialEmail: $initialEmail, initialPassword: $initialPassword, key: $key}';
  }
}
