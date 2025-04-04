abstract class Paths {
  static const _base = 'https://iu-alumni-backend.onrender.com';

  static const events = '$_base/events/events';
  static String eventWithId(String eid) => '$events/$eid';

  static const _auth = '$_base/auth';
  static const login = '$_auth/login';
}
