import '../../models/event.dart';
import '../../models/profile.dart';

abstract class Reporter {
  void init();
  void reportOpenEvent(EventModel event, AppLocation location);
  void reportOpenProfile(Profile profile, AppLocation location);
  void reportParticipate(EventModel event, AppLocation location);
  void reportLeave(EventModel event, AppLocation location);
  void reportTabChanged(String tabName);
  void reportCreateEventTap(AppLocation location);
  void reportEditEventTap(EventModel event, AppLocation location);
  void reportDeleteEvent(EventModel event, AppLocation location);
  void reportSaveEvent(EventModel event, AppLocation location);
  void reportAuthError(String description, AppLocation location);
  void reportAuthSuccessful(AppLocation location);
  void reportUserTelegramOpen(Profile profile, AppLocation location);
  void reportUserTelegramCopy(Profile profile, AppLocation location);
  void reportSaveProfileChanges(AppLocation location);
  void reportEditProfileTap(AppLocation location);
  void reportUnauthorize(AppLocation location);

  void reportNavigation(
    NavAction action,
    String? previousRoute,
    String? newRoute,
  );
}

enum AppLocation {
  mapTab,
  eventsTab,
  profileScreen,
  profileEditingScreen,
  eventScreen,
  eventEditingScreen,
  authScreen,
  verificationScreen,
  none,
}

enum NavAction { push, pop, replace }
