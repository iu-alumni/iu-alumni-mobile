abstract class Paths {
  static const String events = '/events/';
  static String eventsOwner = '${events}owner';
  static String eventsPending = '$eventsOwner/pending';
  static String eventsWhereParticipant(String uid) =>
      '${events}participant/$uid';
  static String eventWithId(String eid) => '$events$eid';
  static String participants(String eid) => '${eventWithId(eid)}/participants';
  static String leave(String eid) => '${eventWithId(eid)}/participants/remove';

  static const String _auth = '/auth';
  static String login = '$_auth/login';
  static String register = '$_auth/register';
  static String resend = '$_auth/resend-verification';
  static String verify = '$_auth/verify';
  static String loginOtpRequest = '$_auth/login/otp/request';
  static String loginOtpVerify = '$_auth/login/otp/verify';
  static String passwordResetRequest = '$_auth/password-reset/request';
  static String passwordResetConfirm = '$_auth/password-reset/confirm';

  static String profile = '/profile/';
  static String myProfile = '${profile}me';
  static String allProfiles = '${profile}all';
  static String mapProfiles = '${profile}map';

  static const String _cities = '/cities';
  static String coordinates = '$_cities/coordinates';
  static String search = '$_cities/search';
}
