// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/cupertino.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:fpdart/fpdart.dart' as _i9;
import 'package:ui_alumni_mobile/application/models/profile.dart' as _i17;
import 'package:ui_alumni_mobile/application/repositories/map/map_repository.dart'
    as _i14;
import 'package:ui_alumni_mobile/presentation/pages/app_loading/app_loading_page.dart'
    as _i1;
import 'package:ui_alumni_mobile/presentation/pages/auth/auth_page.dart' as _i2;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/code_verification_sub_page.dart'
    as _i4;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/registration_sub_page.dart'
    as _i10;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/sign_in_sub_page.dart'
    as _i12;
import 'package:ui_alumni_mobile/presentation/pages/city_data/city_data.dart'
    as _i3;
import 'package:ui_alumni_mobile/presentation/pages/event/event_page.dart'
    as _i6;
import 'package:ui_alumni_mobile/presentation/pages/event_editing/event_editing_page.dart'
    as _i5;
import 'package:ui_alumni_mobile/presentation/pages/profile/profile_page.dart'
    as _i8;
import 'package:ui_alumni_mobile/presentation/pages/profile_editing/profile_editing_page.dart'
    as _i7;
import 'package:ui_alumni_mobile/presentation/pages/root/root_page.dart'
    as _i11;

/// generated route for
/// [_i1.AppLoadingPage]
class AppLoadingRoute extends _i13.PageRouteInfo<void> {
  const AppLoadingRoute({List<_i13.PageRouteInfo>? children})
    : super(AppLoadingRoute.name, initialChildren: children);

  static const String name = 'AppLoadingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i1.AppLoadingPage());
    },
  );
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i13.PageRouteInfo<void> {
  const AuthRoute({List<_i13.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i2.AuthPage());
    },
  );
}

/// generated route for
/// [_i3.CityDataPage]
class CityDataRoute extends _i13.PageRouteInfo<CityDataRouteArgs> {
  CityDataRoute({
    required String city,
    required _i14.CityData cityData,
    _i15.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         CityDataRoute.name,
         args: CityDataRouteArgs(city: city, cityData: cityData, key: key),
         initialChildren: children,
       );

  static const String name = 'CityDataRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CityDataRouteArgs>();
      return _i3.CityDataPage(
        city: args.city,
        cityData: args.cityData,
        key: args.key,
      );
    },
  );
}

class CityDataRouteArgs {
  const CityDataRouteArgs({
    required this.city,
    required this.cityData,
    this.key,
  });

  final String city;

  final _i14.CityData cityData;

  final _i15.Key? key;

  @override
  String toString() {
    return 'CityDataRouteArgs{city: $city, cityData: $cityData, key: $key}';
  }
}

/// generated route for
/// [_i4.CodeVerificationSubPage]
class CodeVerificationSubRoute extends _i13.PageRouteInfo<void> {
  const CodeVerificationSubRoute({List<_i13.PageRouteInfo>? children})
    : super(CodeVerificationSubRoute.name, initialChildren: children);

  static const String name = 'CodeVerificationSubRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.CodeVerificationSubPage();
    },
  );
}

/// generated route for
/// [_i5.EventEditingPage]
class EventEditingRoute extends _i13.PageRouteInfo<EventEditingRouteArgs> {
  EventEditingRoute({
    required _i9.Option<String> eventId,
    _i16.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         EventEditingRoute.name,
         args: EventEditingRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventEditingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventEditingRouteArgs>();
      return _i13.WrappedRoute(
        child: _i5.EventEditingPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventEditingRouteArgs {
  const EventEditingRouteArgs({required this.eventId, this.key});

  final _i9.Option<String> eventId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'EventEditingRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i6.EventPage]
class EventRoute extends _i13.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required String eventId,
    _i16.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         EventRoute.name,
         args: EventRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return _i13.WrappedRoute(
        child: _i6.EventPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final String eventId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i7.ProfileEditingPage]
class ProfileEditingRoute extends _i13.PageRouteInfo<void> {
  const ProfileEditingRoute({List<_i13.PageRouteInfo>? children})
    : super(ProfileEditingRoute.name, initialChildren: children);

  static const String name = 'ProfileEditingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i7.ProfileEditingPage());
    },
  );
}

/// generated route for
/// [_i8.ProfilePage]
class ProfileRoute extends _i13.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i9.Option<_i17.Profile> profile = const _i9.None(),
    _i16.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         ProfileRoute.name,
         args: ProfileRouteArgs(profile: profile, key: key),
         initialChildren: children,
       );

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>(
        orElse: () => const ProfileRouteArgs(),
      );
      return _i13.WrappedRoute(
        child: _i8.ProfilePage(profile: args.profile, key: args.key),
      );
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.profile = const _i9.None(), this.key});

  final _i9.Option<_i17.Profile> profile;

  final _i16.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{profile: $profile, key: $key}';
  }
}

/// generated route for
/// [_i10.RegistrationSubPage]
class RegistrationSubRoute
    extends _i13.PageRouteInfo<RegistrationSubRouteArgs> {
  RegistrationSubRoute({
    required String email,
    required String password,
    _i15.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         RegistrationSubRoute.name,
         args: RegistrationSubRouteArgs(
           email: email,
           password: password,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'RegistrationSubRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegistrationSubRouteArgs>();
      return _i10.RegistrationSubPage(
        email: args.email,
        password: args.password,
        key: args.key,
      );
    },
  );
}

class RegistrationSubRouteArgs {
  const RegistrationSubRouteArgs({
    required this.email,
    required this.password,
    this.key,
  });

  final String email;

  final String password;

  final _i15.Key? key;

  @override
  String toString() {
    return 'RegistrationSubRouteArgs{email: $email, password: $password, key: $key}';
  }
}

/// generated route for
/// [_i11.RootPage]
class RootRoute extends _i13.PageRouteInfo<void> {
  const RootRoute({List<_i13.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i11.RootPage());
    },
  );
}

/// generated route for
/// [_i12.SignInSubPage]
class SignInSubRoute extends _i13.PageRouteInfo<void> {
  const SignInSubRoute({List<_i13.PageRouteInfo>? children})
    : super(SignInSubRoute.name, initialChildren: children);

  static const String name = 'SignInSubRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignInSubPage();
    },
  );
}
