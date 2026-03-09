import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../application/repositories/reporter/reporter.dart';
import '../../data/secrets/secrets_manager.dart';
import '../../data/token/token_provider.dart';
import '../router/app_router.gr.dart';

class AppLoadingManager {
  const AppLoadingManager(
    this._tokenProvider,
    this._reporter,
    this._secretsManager,
  );

  final TokenProvider _tokenProvider;
  final Reporter _reporter;
  final SecretsManager _secretsManager;

  Future<void> init(BuildContext context) async {
    await _secretsManager.init();
    await _tokenProvider.init();
    _reporter.init();
    if (context.mounted) {
      // On web, check if the URL is a password reset link.
      // The backend sends links of the form: <MINI_APP_URL>/reset-password?token=<uuid>
      if (kIsWeb) {
        final uri = Uri.base;
        if (uri.path.contains('reset-password')) {
          final token = uri.queryParameters['token'] ?? '';
          await context.router.replaceAll([
            PasswordResetConfirmRoute(token: token),
          ]);
          return;
        }
      }
      await context.router.replaceAll([
        if (_tokenProvider.token.isNone())
          const AuthRoute()
        else
          const RootRoute(),
      ]);
    }
  }
}
