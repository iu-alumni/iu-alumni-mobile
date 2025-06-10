import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecretsManager {
  late final String? webSalt;
  late final String? appMetricaKey;
  late final String? hostPath;

  Future<void> init() async {
    await dotenv.load(fileName: '.env');
    webSalt = dotenv.env['iu_alumni_web_salt'];
    appMetricaKey = dotenv.env['app_metrica_key'];
    hostPath = dotenv.env['host_path'];
  }
}
