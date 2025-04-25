abstract class Paths {
  static const _base = 'https://iu-alumni-backend.onrender.com';

  static const events = '$_base/events/';
  static String eventWithId(String eid) => '$events$eid';
  static String participants(String eid) => '${eventWithId(eid)}/participants';

  static const _auth = '$_base/auth';
  static const login = '$_auth/login';
  static const verify = '$_auth/verify-graduate';

  static const _profile = '$_base/profile';
  static const myProfile = '$_profile/me';
  static const allProfiles = '$_profile/all';
}
