import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../util/logger.dart';
import '../../models/event.dart';
import '../../models/profile.dart';
import '../users/users_repository.dart';
import 'reporter.dart';

class ReporterImpl extends Reporter with WidgetsBindingObserver {
  ReporterImpl(this._usersRepository);

  final UsersRepository _usersRepository;

  static const _appMetricaKey = String.fromEnvironment('app_metrica_key');

  DateTime? _startTime;

  String? _representAppLocation(AppLocation al) => switch (al) {
        AppLocation.eventScreen => 'event_screen',
        AppLocation.eventsTab => 'events_tab',
        AppLocation.mapTab => 'map_tab',
        AppLocation.none => null,
      };

  void _report({
    required String action,
    required Map<String, Object> payload,
    AppLocation appLocation = AppLocation.none,
  }) async {
    final myProfile = await _usersRepository.loadMe();
    if (!kDebugMode) {
      AppMetrica.reportEventWithMap('ui_alumni_mobile_event', {
        'user_id': myProfile.match(() => 'NONE', (p) => p.profileId),
        if (_representAppLocation(appLocation) case final location?)
          'app_location': location,
        'payload': payload,
      });
    }
    logger.d(
      'Reported an event on ${_representAppLocation(appLocation)}.\nAuthorized: ${myProfile.isSome()}.\nPayload $payload.',
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => switch (state) {
        AppLifecycleState.resumed => _sessionStarted(),
        AppLifecycleState.paused => _sessionStopped(),
        _ => null,
      };

  void _sessionStarted() {
    _startTime = DateTime.now();
    logger.d('Session started at $_startTime');
  }

  void _sessionStopped() {
    if (_startTime case final start?) {
      final finish = DateTime.now();
      final timeSpent = finish.difference(start).inMilliseconds;
      _report(
        action: 'app_time',
        payload: {'appTimeMS': timeSpent},
      );
      logger.d(
        'Report session stopped at $finish and started at $start. Time spent: $timeSpent seconds',
      );
    } else {
      logger.e('Session was stopped but no start time was saved');
    }
  }

  @override
  void init() {
    WidgetsBinding.instance.addObserver(this);
    // Mark the session start
    _sessionStarted();
    try {
      AppMetrica.activate(const AppMetricaConfig(_appMetricaKey));
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void reportOpenEvent(EventModel event, AppLocation location) => _report(
        action: 'event_tap',
        appLocation: location,
        payload: {
          'event_id': event.eventId,
          if (event.location case final geoLocation?
              when location == AppLocation.mapTab)
            'geo_location': geoLocation,
        },
      );

  @override
  void reportOpenProfile(Profile profile, AppLocation location) => _report(
        action: 'profile_tap',
        appLocation: location,
        payload: {
          'profile_id': profile.profileId,
          if (profile.location case final geoLocation?
              when location == AppLocation.mapTab)
            'geo_location': geoLocation,
        },
      );

  @override
  void reportParticipate(EventModel event, AppLocation location) => _report(
        action: 'participate_tap',
        appLocation: location,
        payload: {'event_id': event.eventId},
      );

  @override
  void reportLeave(EventModel event, AppLocation location) => _report(
        action: 'leave_tap',
        appLocation: location,
        payload: {'event_id': event.eventId},
      );

  String _representAction(NavAction action) => switch (action) {
        NavAction.pop => 'pop',
        NavAction.push => 'push',
        NavAction.replace => 'replace',
      };

  @override
  void reportNavigation(
    NavAction action,
    String? previousRoute,
    String? newRoute,
  ) =>
      _report(
        action: 'navigation/${_representAction(action)}',
        payload: {
          if (previousRoute case final route?) 'prev_route': route,
          if (newRoute case final route?) 'new_route': route,
        },
      );
}
