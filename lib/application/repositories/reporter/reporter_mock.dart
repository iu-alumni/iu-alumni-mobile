import '../../models/event.dart';
import '../../models/profile.dart';
import 'reporter.dart';

class ReporterMock extends Reporter {
  @override
  void init() {
    // TODO: implement init
  }

  @override
  void reportAuthError(String description, AppLocation location) {
    // TODO: implement reportAuthError
  }

  @override
  void reportAuthSuccessful(AppLocation location) {
    // TODO: implement reportAuthSuccessful
  }

  @override
  void reportCreateEventTap(AppLocation location) {
    // TODO: implement reportCreateEventTap
  }

  @override
  void reportDeleteEvent(EventModel event, AppLocation location) {
    // TODO: implement reportDeleteEvent
  }

  @override
  void reportEditEventTap(EventModel event, AppLocation location) {
    // TODO: implement reportEditEventTap
  }

  @override
  void reportEditProfileTap(AppLocation location) {
    // TODO: implement reportEditProfileTap
  }

  @override
  void reportLeave(EventModel event, AppLocation location) {
    // TODO: implement reportLeave
  }

  @override
  void reportNavigation(
      NavAction action, String? previousRoute, String? newRoute) {
    // TODO: implement reportNavigation
  }

  @override
  void reportOpenEvent(EventModel event, AppLocation location) {
    // TODO: implement reportOpenEvent
  }

  @override
  void reportOpenProfile(Profile profile, AppLocation location) {
    // TODO: implement reportOpenProfile
  }

  @override
  void reportParticipate(EventModel event, AppLocation location) {
    // TODO: implement reportParticipate
  }

  @override
  void reportSaveEvent(EventModel event, AppLocation location) {
    // TODO: implement reportSaveEvent
  }

  @override
  void reportSaveProfileChanges(AppLocation location) {
    // TODO: implement reportSaveProfileChanges
  }

  @override
  void reportTabChanged(String tabName) {
    // TODO: implement reportTabChanged
  }

  @override
  void reportUnauthorize(AppLocation location) {
    // TODO: implement reportUnauthorize
  }

  @override
  void reportUserTelegramCopy(Profile profile, AppLocation location) {
    // TODO: implement reportUserTelegramCopy
  }

  @override
  void reportUserTelegramOpen(Profile profile, AppLocation location) {
    // TODO: implement reportUserTelegramOpen
  }
}
