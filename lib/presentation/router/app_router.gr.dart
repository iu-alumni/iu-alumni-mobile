// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/cupertino.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:fpdart/fpdart.dart' as _i6;
import 'package:ui_alumni_mobile/application/models/profile.dart' as _i18;
import 'package:ui_alumni_mobile/application/repositories/map/map_repository.dart'
    as _i15;
import 'package:ui_alumni_mobile/presentation/pages/app_loading/app_loading_page.dart'
    as _i1;
import 'package:ui_alumni_mobile/presentation/pages/auth/auth_page.dart' as _i2;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/code_verification_sub_page.dart'
    as _i4;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/registration_sub_page.dart'
    as _i10;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/restored_verification_sub_page.dart'
    as _i11;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/sign_in_sub_page.dart'
    as _i13;
import 'package:ui_alumni_mobile/presentation/pages/city_data/city_data.dart'
    as _i3;
import 'package:ui_alumni_mobile/presentation/pages/event/event_page.dart'
    as _i7;
import 'package:ui_alumni_mobile/presentation/pages/event_editing/event_editing_page.dart'
    as _i5;
import 'package:ui_alumni_mobile/presentation/pages/profile/profile_page.dart'
    as _i9;
import 'package:ui_alumni_mobile/presentation/pages/profile_editing/profile_editing_page.dart'
    as _i8;
import 'package:ui_alumni_mobile/presentation/pages/root/root_page.dart'
    as _i12;

/// generated route for
/// [_i1.AppLoadingPage]
class AppLoadingRoute extends _i14.PageRouteInfo<void> {
  const AppLoadingRoute({List<_i14.PageRouteInfo>? children})
    : super(AppLoadingRoute.name, initialChildren: children);

  static const String name = 'AppLoadingRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i14.WrappedRoute(child: const _i1.AppLoadingPage());
    },
  );
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i14.PageRouteInfo<void> {
  const AuthRoute({List<_i14.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i14.WrappedRoute(child: const _i2.AuthPage());
    },
  );
}

/// generated route for
/// [_i3.CityDataPage]
class CityDataRoute extends _i14.PageRouteInfo<CityDataRouteArgs> {
  CityDataRoute({
    required _i15.CityData cityData,
    required _i15.NamedCoordinates coords,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         CityDataRoute.name,
         args: CityDataRouteArgs(cityData: cityData, coords: coords, key: key),
         initialChildren: children,
       );

  static const String name = 'CityDataRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CityDataRouteArgs>();
      return _i3.CityDataPage(
        cityData: args.cityData,
        coords: args.coords,
        key: args.key,
      );
    },
  );
}

class CityDataRouteArgs {
  const CityDataRouteArgs({
    required this.cityData,
    required this.coords,
    this.key,
  });

  final _i15.CityData cityData;

  final _i15.NamedCoordinates coords;

  final _i16.Key? key;

  @override
  String toString() {
    return 'CityDataRouteArgs{cityData: $cityData, coords: $coords, key: $key}';
  }
}

/// generated route for
/// [_i4.CodeVerificationSubPage]
class CodeVerificationSubRoute extends _i14.PageRouteInfo<void> {
  const CodeVerificationSubRoute({List<_i14.PageRouteInfo>? children})
    : super(CodeVerificationSubRoute.name, initialChildren: children);

  static const String name = 'CodeVerificationSubRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.CodeVerificationSubPage();
    },
  );
}

/// generated route for
/// [_i5.EventEditingPage]
class EventEditingRoute extends _i14.PageRouteInfo<EventEditingRouteArgs> {
  EventEditingRoute({
    required _i6.Option<String> eventId,
    _i6.Option<String> location = const _i6.None(),
    _i17.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         EventEditingRoute.name,
         args: EventEditingRouteArgs(
           eventId: eventId,
           location: location,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'EventEditingRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventEditingRouteArgs>();
      return _i14.WrappedRoute(
        child: _i5.EventEditingPage(
          eventId: args.eventId,
          location: args.location,
          key: args.key,
        ),
      );
    },
  );
}

class EventEditingRouteArgs {
  const EventEditingRouteArgs({
    required this.eventId,
    this.location = const _i6.None(),
    this.key,
  });

  final _i6.Option<String> eventId;

  final _i6.Option<String> location;

  final _i17.Key? key;

  @override
  String toString() {
    return 'EventEditingRouteArgs{eventId: $eventId, location: $location, key: $key}';
  }
}

/// generated route for
/// [_i7.EventPage]
class EventRoute extends _i14.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required String eventId,
    _i17.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         EventRoute.name,
         args: EventRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return _i14.WrappedRoute(
        child: _i7.EventPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final String eventId;

  final _i17.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i8.ProfileEditingPage]
class ProfileEditingRoute extends _i14.PageRouteInfo<void> {
  const ProfileEditingRoute({List<_i14.PageRouteInfo>? children})
    : super(ProfileEditingRoute.name, initialChildren: children);

  static const String name = 'ProfileEditingRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i14.WrappedRoute(child: const _i8.ProfileEditingPage());
    },
  );
}

/// generated route for
/// [_i9.ProfilePage]
class ProfileRoute extends _i14.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i6.Option<_i18.Profile> profile = const _i6.None(),
    _i17.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         ProfileRoute.name,
         args: ProfileRouteArgs(profile: profile, key: key),
         initialChildren: children,
       );

  static const String name = 'ProfileRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>(
        orElse: () => const ProfileRouteArgs(),
      );
      return _i14.WrappedRoute(
        child: _i9.ProfilePage(profile: args.profile, key: args.key),
      );
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.profile = const _i6.None(), this.key});

  final _i6.Option<_i18.Profile> profile;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{profile: $profile, key: $key}';
  }
}

/// generated route for
/// [_i10.RegistrationSubPage]
class RegistrationSubRoute
    extends _i14.PageRouteInfo<RegistrationSubRouteArgs> {
  RegistrationSubRoute({
    required String email,
    required String password,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
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

  static _i14.PageInfo page = _i14.PageInfo(
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

  final _i16.Key? key;

  @override
  String toString() {
    return 'RegistrationSubRouteArgs{email: $email, password: $password, key: $key}';
  }
}

/// generated route for
/// [_i11.RestoredVerificationSubPage]
class RestoredVerificationSubRoute extends _i14.PageRouteInfo<void> {
  const RestoredVerificationSubRoute({List<_i14.PageRouteInfo>? children})
    : super(RestoredVerificationSubRoute.name, initialChildren: children);

  static const String name = 'RestoredVerificationSubRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.RestoredVerificationSubPage();
    },
  );
}

/// generated route for
/// [_i12.RootPage]
class RootRoute extends _i14.PageRouteInfo<void> {
  const RootRoute({List<_i14.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i14.WrappedRoute(child: const _i12.RootPage());
    },
  );
}

/// generated route for
/// [_i13.SignInSubPage]
class SignInSubRoute extends _i14.PageRouteInfo<void> {
  const SignInSubRoute({List<_i14.PageRouteInfo>? children})
    : super(SignInSubRoute.name, initialChildren: children);

  static const String name = 'SignInSubRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.SignInSubPage();
    },
  );
}
