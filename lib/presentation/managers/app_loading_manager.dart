import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../application/repositories/reporter/reporter.dart';
import '../../data/db/db_manager.dart';
import '../../data/secrets/secrets_manager.dart';
import '../../data/token/token_provider.dart';
import '../router/app_router.gr.dart';

class AppLoadingManager {
  const AppLoadingManager(
    this._tokenProvider,
    this._dbManager,
    this._reporter,
    this._secretsManager,
  );

  final TokenProvider _tokenProvider;
  final DbManager _dbManager;
  final Reporter _reporter;
  final SecretsManager _secretsManager;

  Future<void> init(BuildContext context) async {
    await _secretsManager.init();
    await _tokenProvider.init();
    _dbManager.init();
    _reporter.init();
    if (context.mounted) {
      context.router.replaceAll([
        if (_tokenProvider.token.isNone())
          const AuthRoute()
        else
          const RootRoute()
      ]);
    }
  }
}
