import 'package:ui_alumni_mobile/data/config/api_config.dart';

class SecretsManager {
  String? webSalt;
  String? appMetricaKey;
  String? hostPath;

  Future<void> init() async {
    webSalt = const String.fromEnvironment('IU_ALUMNI_WEB_SALT');
    appMetricaKey = const String.fromEnvironment('APP_METRICA_KEY');
    hostPath = getApiBaseUrl();
  }
}
