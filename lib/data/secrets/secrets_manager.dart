// import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecretsManager {
  String? webSalt;
  String? hostPath;

  Future<void> init() async {
    webSalt =
        const String.fromEnvironment('iu_alumni_web_salt');
    hostPath =
        const String.fromEnvironment('API_BASE_URL');
  }
}
