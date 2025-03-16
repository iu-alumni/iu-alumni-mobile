abstract class Paths {
  static const _base = 'https://iu-alumni-backend.onrender.com';
  static const events = '$_base/events/events';
  static String eventWithId(String eid) => '$_base/events/events/$eid';
}
