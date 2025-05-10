import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../data/db/db_manager.dart';
import '../../data/token/token_provider.dart';
import '../router/app_router.gr.dart';

class AppLoadingManager {
  const AppLoadingManager(this._tokenProvider, this._dbManager);

  final TokenProvider _tokenProvider;
  final DbManager _dbManager;

  Future<void> init(BuildContext context) async {
    await _tokenProvider.init();
    _dbManager.init();
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
