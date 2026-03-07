import 'package:appmetrica_plugin/appmetrica_plugin.dart';

import '../../../data/secrets/secrets_manager.dart';
import '../../models/event.dart';
import '../../models/profile.dart';
import 'reporter.dart';

class ReporterAppMetrica implements Reporter {
  ReporterAppMetrica(this._secretsManager);

  final SecretsManager _secretsManager;
  bool _activated = false;

  @override
  void init() {
    final key = _secretsManager.appMetricaKey;
    if (key != null && key.isNotEmpty) {
      AppMetrica.activate(AppMetricaConfig(key));
      _activated = true;
    }
  }

  void _report(String name, [Map<String, Object>? params]) {
    if (!_activated) return;
    if (params != null) {
      AppMetrica.reportEventWithMap(name, params);
    } else {
      AppMetrica.reportEvent(name);
    }
  }

  @override
  void reportOpenEvent(EventModel event, AppLocation location) =>
      _report('open_event', {'event_id': event.eventId, 'location': location.name});

  @override
  void reportOpenProfile(Profile profile, AppLocation location) =>
      _report('open_profile', {'user_id': profile.profileId, 'location': location.name});

  @override
  void reportParticipate(EventModel event, AppLocation location) =>
      _report('participate_event', {'event_id': event.eventId, 'location': location.name});

  @override
  void reportLeave(EventModel event, AppLocation location) =>
      _report('leave_event', {'event_id': event.eventId, 'location': location.name});

  @override
  void reportTabChanged(String tabName) =>
      _report('tab_changed', {'tab': tabName});

  @override
  void reportCreateEventTap(AppLocation location) =>
      _report('create_event_tap', {'location': location.name});

  @override
  void reportEditEventTap(EventModel event, AppLocation location) =>
      _report('edit_event_tap', {'event_id': event.eventId, 'location': location.name});

  @override
  void reportDeleteEvent(EventModel event, AppLocation location) =>
      _report('delete_event', {'event_id': event.eventId, 'location': location.name});

  @override
  void reportSaveEvent(EventModel event, AppLocation location) =>
      _report('save_event', {'event_id': event.eventId, 'location': location.name});

  @override
  void reportAuthError(String description, AppLocation location) =>
      _report('auth_error', {'description': description, 'location': location.name});

  @override
  void reportAuthSuccessful(AppLocation location) =>
      _report('auth_successful', {'location': location.name});

  @override
  void reportUserTelegramOpen(Profile profile, AppLocation location) =>
      _report('user_telegram_open', {'user_id': profile.profileId, 'location': location.name});

  @override
  void reportUserTelegramCopy(Profile profile, AppLocation location) =>
      _report('user_telegram_copy', {'user_id': profile.profileId, 'location': location.name});

  @override
  void reportSaveProfileChanges(AppLocation location) =>
      _report('save_profile_changes', {'location': location.name});

  @override
  void reportEditProfileTap(AppLocation location) =>
      _report('edit_profile_tap', {'location': location.name});

  @override
  void reportUnauthorize(AppLocation location) =>
      _report('unauthorize', {'location': location.name});

  @override
  void reportOpenMapLocation(String cityName, AppLocation location) =>
      _report('open_map_location', {'city': cityName, 'location': location.name});

  @override
  void reportNavigation(NavAction action, String? previousRoute, String? newRoute) =>
      _report('navigation', {
        'action': action.name,
        'from': previousRoute ?? '',
        'to': newRoute ?? '',
      });
}
