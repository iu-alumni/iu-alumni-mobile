// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i10;
import 'package:fpdart/fpdart.dart' as _i9;
import 'package:ui_alumni_mobile/presentation/pages/app_loading/app_loading_page.dart'
    as _i1;
import 'package:ui_alumni_mobile/presentation/pages/auth/auth_page.dart' as _i2;
import 'package:ui_alumni_mobile/presentation/pages/event/event_page.dart'
    as _i4;
import 'package:ui_alumni_mobile/presentation/pages/event_editing/event_editing_page.dart'
    as _i3;
import 'package:ui_alumni_mobile/presentation/pages/profile_editing/profile_editing_page.dart'
    as _i5;
import 'package:ui_alumni_mobile/presentation/pages/root/root_page.dart' as _i6;
import 'package:ui_alumni_mobile/presentation/pages/verification/verification_page.dart'
    as _i7;

/// generated route for
/// [_i1.AppLoadingPage]
class AppLoadingRoute extends _i8.PageRouteInfo<void> {
  const AppLoadingRoute({List<_i8.PageRouteInfo>? children})
    : super(AppLoadingRoute.name, initialChildren: children);

  static const String name = 'AppLoadingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i1.AppLoadingPage());
    },
  );
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i8.PageRouteInfo<void> {
  const AuthRoute({List<_i8.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i2.AuthPage());
    },
  );
}

/// generated route for
/// [_i3.EventEditingPage]
class EventEditingRoute extends _i8.PageRouteInfo<EventEditingRouteArgs> {
  EventEditingRoute({
    required _i9.Option<String> eventId,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         EventEditingRoute.name,
         args: EventEditingRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventEditingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventEditingRouteArgs>();
      return _i8.WrappedRoute(
        child: _i3.EventEditingPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventEditingRouteArgs {
  const EventEditingRouteArgs({required this.eventId, this.key});

  final _i9.Option<String> eventId;

  final _i10.Key? key;

  @override
  String toString() {
    return 'EventEditingRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i4.EventPage]
class EventRoute extends _i8.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required String eventId,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         EventRoute.name,
         args: EventRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return _i8.WrappedRoute(
        child: _i4.EventPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final String eventId;

  final _i10.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i5.ProfileEditingPage]
class ProfileEditingRoute extends _i8.PageRouteInfo<void> {
  const ProfileEditingRoute({List<_i8.PageRouteInfo>? children})
    : super(ProfileEditingRoute.name, initialChildren: children);

  static const String name = 'ProfileEditingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i5.ProfileEditingPage());
    },
  );
}

/// generated route for
/// [_i6.RootPage]
class RootRoute extends _i8.PageRouteInfo<void> {
  const RootRoute({List<_i8.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i6.RootPage());
    },
  );
}

/// generated route for
/// [_i7.VerificationPage]
class VerificationRoute extends _i8.PageRouteInfo<VerificationRouteArgs> {
  VerificationRoute({
    required String initialEmail,
    required String? initialPassword,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
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

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerificationRouteArgs>();
      return _i8.WrappedRoute(
        child: _i7.VerificationPage(
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

  final _i10.Key? key;

  @override
  String toString() {
    return 'VerificationRouteArgs{initialEmail: $initialEmail, initialPassword: $initialPassword, key: $key}';
  }
}
