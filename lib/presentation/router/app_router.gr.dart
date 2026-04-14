// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/cupertino.dart' as _i23;
import 'package:flutter/material.dart' as _i24;
import 'package:fpdart/fpdart.dart' as _i6;
import 'package:ui_alumni_mobile/application/models/profile.dart' as _i25;
import 'package:ui_alumni_mobile/application/repositories/map/map_repository.dart'
    as _i22;
import 'package:ui_alumni_mobile/presentation/pages/app_loading/app_loading_page.dart'
    as _i1;
import 'package:ui_alumni_mobile/presentation/pages/auth/auth_page.dart' as _i2;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/code_verification_sub_page.dart'
    as _i4;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/otp_request_sub_page.dart'
    as _i8;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/otp_verify_sub_page.dart'
    as _i9;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/password_reset_request_sub_page.dart'
    as _i11;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/registration_sub_page.dart'
    as _i14;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/restored_verification_sub_page.dart'
    as _i15;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/sign_in_sub_page.dart'
    as _i17;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/telegram_otp_request_sub_page.dart'
    as _i18;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/telegram_otp_verify_sub_page.dart'
    as _i19;
import 'package:ui_alumni_mobile/presentation/pages/auth/subpages/verification_way_sub_page.dart'
    as _i20;
import 'package:ui_alumni_mobile/presentation/pages/city_data/city_data.dart'
    as _i3;
import 'package:ui_alumni_mobile/presentation/pages/event/event_page.dart'
    as _i7;
import 'package:ui_alumni_mobile/presentation/pages/event_editing/event_editing_page.dart'
    as _i5;
import 'package:ui_alumni_mobile/presentation/pages/password_reset/password_reset_confirm_page.dart'
    as _i10;
import 'package:ui_alumni_mobile/presentation/pages/profile/profile_page.dart'
    as _i13;
import 'package:ui_alumni_mobile/presentation/pages/profile_editing/profile_editing_page.dart'
    as _i12;
import 'package:ui_alumni_mobile/presentation/pages/root/root_page.dart'
    as _i16;

/// generated route for
/// [_i1.AppLoadingPage]
class AppLoadingRoute extends _i21.PageRouteInfo<void> {
  const AppLoadingRoute({List<_i21.PageRouteInfo>? children})
    : super(AppLoadingRoute.name, initialChildren: children);

  static const String name = 'AppLoadingRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return _i21.WrappedRoute(child: const _i1.AppLoadingPage());
    },
  );
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i21.PageRouteInfo<void> {
  const AuthRoute({List<_i21.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return _i21.WrappedRoute(child: const _i2.AuthPage());
    },
  );
}

/// generated route for
/// [_i3.CityDataPage]
class CityDataRoute extends _i21.PageRouteInfo<CityDataRouteArgs> {
  CityDataRoute({
    required _i22.CityData cityData,
    required _i22.NamedCoordinates coords,
    _i23.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         CityDataRoute.name,
         args: CityDataRouteArgs(cityData: cityData, coords: coords, key: key),
         initialChildren: children,
       );

  static const String name = 'CityDataRoute';

  static _i21.PageInfo page = _i21.PageInfo(
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

  final _i22.CityData cityData;

  final _i22.NamedCoordinates coords;

  final _i23.Key? key;

  @override
  String toString() {
    return 'CityDataRouteArgs{cityData: $cityData, coords: $coords, key: $key}';
  }
}

/// generated route for
/// [_i4.CodeVerificationSubPage]
class CodeVerificationSubRoute extends _i21.PageRouteInfo<void> {
  const CodeVerificationSubRoute({List<_i21.PageRouteInfo>? children})
    : super(CodeVerificationSubRoute.name, initialChildren: children);

  static const String name = 'CodeVerificationSubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i4.CodeVerificationSubPage();
    },
  );
}

/// generated route for
/// [_i5.EventEditingPage]
class EventEditingRoute extends _i21.PageRouteInfo<EventEditingRouteArgs> {
  EventEditingRoute({
    required _i6.Option<String> eventId,
    _i6.Option<String> location = const _i6.None(),
    _i24.Key? key,
    List<_i21.PageRouteInfo>? children,
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

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventEditingRouteArgs>();
      return _i21.WrappedRoute(
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

  final _i24.Key? key;

  @override
  String toString() {
    return 'EventEditingRouteArgs{eventId: $eventId, location: $location, key: $key}';
  }
}

/// generated route for
/// [_i7.EventPage]
class EventRoute extends _i21.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required String eventId,
    _i24.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         EventRoute.name,
         args: EventRouteArgs(eventId: eventId, key: key),
         initialChildren: children,
       );

  static const String name = 'EventRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return _i21.WrappedRoute(
        child: _i7.EventPage(eventId: args.eventId, key: args.key),
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final String eventId;

  final _i24.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i8.OtpRequestSubPage]
class OtpRequestSubRoute extends _i21.PageRouteInfo<OtpRequestSubRouteArgs> {
  OtpRequestSubRoute({
    _i24.Key? key,
    String email = '',
    List<_i21.PageRouteInfo>? children,
  }) : super(
         OtpRequestSubRoute.name,
         args: OtpRequestSubRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'OtpRequestSubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRequestSubRouteArgs>(
        orElse: () => const OtpRequestSubRouteArgs(),
      );
      return _i8.OtpRequestSubPage(key: args.key, email: args.email);
    },
  );
}

class OtpRequestSubRouteArgs {
  const OtpRequestSubRouteArgs({this.key, this.email = ''});

  final _i24.Key? key;

  final String email;

  @override
  String toString() {
    return 'OtpRequestSubRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i9.OtpVerifySubPage]
class OtpVerifySubRoute extends _i21.PageRouteInfo<void> {
  const OtpVerifySubRoute({List<_i21.PageRouteInfo>? children})
    : super(OtpVerifySubRoute.name, initialChildren: children);

  static const String name = 'OtpVerifySubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i9.OtpVerifySubPage();
    },
  );
}

/// generated route for
/// [_i10.PasswordResetConfirmPage]
class PasswordResetConfirmRoute
    extends _i21.PageRouteInfo<PasswordResetConfirmRouteArgs> {
  PasswordResetConfirmRoute({
    _i24.Key? key,
    required String token,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         PasswordResetConfirmRoute.name,
         args: PasswordResetConfirmRouteArgs(key: key, token: token),
         initialChildren: children,
       );

  static const String name = 'PasswordResetConfirmRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PasswordResetConfirmRouteArgs>();
      return _i21.WrappedRoute(
        child: _i10.PasswordResetConfirmPage(key: args.key, token: args.token),
      );
    },
  );
}

class PasswordResetConfirmRouteArgs {
  const PasswordResetConfirmRouteArgs({this.key, required this.token});

  final _i24.Key? key;

  final String token;

  @override
  String toString() {
    return 'PasswordResetConfirmRouteArgs{key: $key, token: $token}';
  }
}

/// generated route for
/// [_i11.PasswordResetRequestSubPage]
class PasswordResetRequestSubRoute extends _i21.PageRouteInfo<void> {
  const PasswordResetRequestSubRoute({List<_i21.PageRouteInfo>? children})
    : super(PasswordResetRequestSubRoute.name, initialChildren: children);

  static const String name = 'PasswordResetRequestSubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i11.PasswordResetRequestSubPage();
    },
  );
}

/// generated route for
/// [_i12.ProfileEditingPage]
class ProfileEditingRoute extends _i21.PageRouteInfo<void> {
  const ProfileEditingRoute({List<_i21.PageRouteInfo>? children})
    : super(ProfileEditingRoute.name, initialChildren: children);

  static const String name = 'ProfileEditingRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return _i21.WrappedRoute(child: const _i12.ProfileEditingPage());
    },
  );
}

/// generated route for
/// [_i13.ProfilePage]
class ProfileRoute extends _i21.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i6.Option<_i25.Profile> profile = const _i6.None(),
    _i24.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         ProfileRoute.name,
         args: ProfileRouteArgs(profile: profile, key: key),
         initialChildren: children,
       );

  static const String name = 'ProfileRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>(
        orElse: () => const ProfileRouteArgs(),
      );
      return _i21.WrappedRoute(
        child: _i13.ProfilePage(profile: args.profile, key: args.key),
      );
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.profile = const _i6.None(), this.key});

  final _i6.Option<_i25.Profile> profile;

  final _i24.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{profile: $profile, key: $key}';
  }
}

/// generated route for
/// [_i14.RegistrationSubPage]
class RegistrationSubRoute
    extends _i21.PageRouteInfo<RegistrationSubRouteArgs> {
  RegistrationSubRoute({
    required String email,
    required String password,
    _i24.Key? key,
    List<_i21.PageRouteInfo>? children,
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

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegistrationSubRouteArgs>();
      return _i14.RegistrationSubPage(
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

  final _i24.Key? key;

  @override
  String toString() {
    return 'RegistrationSubRouteArgs{email: $email, password: $password, key: $key}';
  }
}

/// generated route for
/// [_i15.RestoredVerificationSubPage]
class RestoredVerificationSubRoute extends _i21.PageRouteInfo<void> {
  const RestoredVerificationSubRoute({List<_i21.PageRouteInfo>? children})
    : super(RestoredVerificationSubRoute.name, initialChildren: children);

  static const String name = 'RestoredVerificationSubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i15.RestoredVerificationSubPage();
    },
  );
}

/// generated route for
/// [_i16.RootPage]
class RootRoute extends _i21.PageRouteInfo<void> {
  const RootRoute({List<_i21.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return _i21.WrappedRoute(child: const _i16.RootPage());
    },
  );
}

/// generated route for
/// [_i17.SignInSubPage]
class SignInSubRoute extends _i21.PageRouteInfo<void> {
  const SignInSubRoute({List<_i21.PageRouteInfo>? children})
    : super(SignInSubRoute.name, initialChildren: children);

  static const String name = 'SignInSubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i17.SignInSubPage();
    },
  );
}

/// generated route for
/// [_i18.TelegramOtpRequestSubPage]
class TelegramOtpRequestSubRoute
    extends _i21.PageRouteInfo<TelegramOtpRequestSubRouteArgs> {
  TelegramOtpRequestSubRoute({
    _i24.Key? key,
    String email = '',
    List<_i21.PageRouteInfo>? children,
  }) : super(
         TelegramOtpRequestSubRoute.name,
         args: TelegramOtpRequestSubRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'TelegramOtpRequestSubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TelegramOtpRequestSubRouteArgs>(
        orElse: () => const TelegramOtpRequestSubRouteArgs(),
      );
      return _i18.TelegramOtpRequestSubPage(key: args.key, email: args.email);
    },
  );
}

class TelegramOtpRequestSubRouteArgs {
  const TelegramOtpRequestSubRouteArgs({this.key, this.email = ''});

  final _i24.Key? key;

  final String email;

  @override
  String toString() {
    return 'TelegramOtpRequestSubRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i19.TelegramOtpVerifySubPage]
class TelegramOtpVerifySubRoute extends _i21.PageRouteInfo<void> {
  const TelegramOtpVerifySubRoute({List<_i21.PageRouteInfo>? children})
    : super(TelegramOtpVerifySubRoute.name, initialChildren: children);

  static const String name = 'TelegramOtpVerifySubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i19.TelegramOtpVerifySubPage();
    },
  );
}

/// generated route for
/// [_i20.VerificationWaySubPage]
class VerificationWaySubRoute extends _i21.PageRouteInfo<void> {
  const VerificationWaySubRoute({List<_i21.PageRouteInfo>? children})
    : super(VerificationWaySubRoute.name, initialChildren: children);

  static const String name = 'VerificationWaySubRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i20.VerificationWaySubPage();
    },
  );
}
