import '../../models/event.dart';
import '../../models/profile.dart';

abstract class Reporter {
  void init();
  void reportOpenEvent(EventModel event, AppLocation location);
  void reportOpenProfile(Profile profile, AppLocation location);
  void reportParticipate(EventModel event, AppLocation location);
  void reportLeave(EventModel event, AppLocation location);

  void reportNavigation(
    NavAction action,
    String? previousRoute,
    String? newRoute,
  );
}

enum AppLocation { mapTab, eventsTab, eventScreen, none }

enum NavAction { push, pop, replace }
