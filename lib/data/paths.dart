abstract class Paths {
  static const _defaultBase = 'https://iu-alumni-backend.onrender.com';

  static String events(String? base) => '${base ?? _defaultBase}/events/';
  static String eventsOwner(String? base) => '${events(base)}owner';
  static String eventsWhereParticipant(String? base, String uid) =>
      '${events(base)}participant/$uid';
  static String eventWithId(String? base, String eid) => '${events(base)}$eid';
  static String participants(String? base, String eid) =>
      '${eventWithId(base, eid)}/participants';
  static String leave(String? base, String eid) =>
      '${eventWithId(base, eid)}/participants/remove';

  static String _auth(String? base) => '${base ?? _defaultBase}/auth';
  static String login(String? base) => '${_auth(base)}/login';
  static String register(String? base) => '${_auth(base)}/register';
  static String resend(String? base) => '${_auth(base)}/resend-verification';
  static String verify(String? base) => '${_auth(base)}/verify';

  static String profile(String? base) => '${base ?? _defaultBase}/profile';
  static String myProfile(String? base) => '${profile(base)}/me';
  static String allProfiles(String? base) => '${profile(base)}/all';
}
