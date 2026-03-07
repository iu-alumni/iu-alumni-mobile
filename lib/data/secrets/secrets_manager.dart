class SecretsManager {
  String? webSalt;
  String? appMetricaKey;
  String? hostPath;

  Future<void> init() async {
    webSalt = const String.fromEnvironment('IU_ALUMNI_WEB_SALT');
    appMetricaKey = const String.fromEnvironment('APP_METRICA_KEY');
    hostPath = const String.fromEnvironment('API_BASE_URL');
  }
}
