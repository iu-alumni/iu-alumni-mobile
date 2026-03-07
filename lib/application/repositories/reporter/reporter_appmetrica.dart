import 'package:appmetrica_plugin/appmetrica_plugin.dart';

import '../../../data/secrets/secrets_manager.dart';
import '../../models/event.dart';
import '../../models/profile.dart';
import 'reporter.dart';

class ReporterAppMetrica implements Reporter {
  ReporterAppMetrica(this._secretsManager);

  final SecretsManager _secretsManager;

  @override
  void init() {
    final key = _secretsManager.appMetricaKey;
    if (key != null && key.isNotEmpty) {
      AppMetrica.activate(AppMetricaConfig(key));
    }
  }

  @override
  void reportOpenEvent(EventModel event, AppLocation location) =>
      AppMetrica.reportEventWithMap('open_event', {
        'event_id': event.eventId,
        'location': location.name,
      });

  @override
  void reportOpenProfile(Profile profile, AppLocation location) =>
      AppMetrica.reportEventWithMap('open_profile', {
        'user_id': profile.profileId,
        'location': location.name,
      });

  @override
  void reportParticipate(EventModel event, AppLocation location) =>
      AppMetrica.reportEventWithMap('participate_event', {
        'event_id': event.eventId,
        'location': location.name,
      });

  @override
  void reportLeave(EventModel event, AppLocation location) =>
      AppMetrica.reportEventWithMap('leave_event', {
        'event_id': event.eventId,
        'location': location.name,
      });

  @override
  void reportTabChanged(String tabName) =>
      AppMetrica.reportEventWithMap('tab_changed', {'tab': tabName});

  @override
  void reportCreateEventTap(AppLocation location) =>
      AppMetrica.reportEventWithMap('create_event_tap', {'location': location.name});

  @override
  void reportEditEventTap(EventModel event, AppLocation location) =>
      AppMetrica.reportEventWithMap('edit_event_tap', {
        'event_id': event.eventId,
        'location': location.name,
      });

  @override
  void reportDeleteEvent(EventModel event, AppLocation location) =>
      AppMetrica.reportEventWithMap('delete_event', {
        'event_id': event.eventId,
        'location': location.name,
      });

  @override
  void reportSaveEvent(EventModel event, AppLocation location) =>
      AppMetrica.reportEventWithMap('save_event', {
        'event_id': event.eventId,
        'location': location.name,
      });

  @override
  void reportAuthError(String description, AppLocation location) =>
      AppMetrica.reportEventWithMap('auth_error', {
        'description': description,
        'location': location.name,
      });

  @override
  void reportAuthSuccessful(AppLocation location) =>
      AppMetrica.reportEventWithMap('auth_successful', {'location': location.name});

  @override
  void reportUserTelegramOpen(Profile profile, AppLocation location) =>
      AppMetrica.reportEventWithMap('user_telegram_open', {
        'user_id': profile.profileId,
        'location': location.name,
      });

  @override
  void reportUserTelegramCopy(Profile profile, AppLocation location) =>
      AppMetrica.reportEventWithMap('user_telegram_copy', {
        'user_id': profile.profileId,
        'location': location.name,
      });

  @override
  void reportSaveProfileChanges(AppLocation location) =>
      AppMetrica.reportEventWithMap('save_profile_changes', {'location': location.name});

  @override
  void reportEditProfileTap(AppLocation location) =>
      AppMetrica.reportEventWithMap('edit_profile_tap', {'location': location.name});

  @override
  void reportUnauthorize(AppLocation location) =>
      AppMetrica.reportEventWithMap('unauthorize', {'location': location.name});

  @override
  void reportOpenMapLocation(String cityName, AppLocation location) =>
      AppMetrica.reportEventWithMap('open_map_location', {
        'city': cityName,
        'location': location.name,
      });

  @override
  void reportNavigation(NavAction action, String? previousRoute, String? newRoute) =>
      AppMetrica.reportEventWithMap('navigation', {
        'action': action.name,
        'from': previousRoute ?? '',
        'to': newRoute ?? '',
      });
}
