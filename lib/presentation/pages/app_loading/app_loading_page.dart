import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/db/db_manager.dart';
import '../../../data/token/token_provider.dart';
import '../../common/widgets/alumni_logo.dart';
import '../../managers/app_loading_manager.dart';

@RoutePage()
class AppLoadingPage extends StatefulWidget implements AutoRouteWrapper {
  const AppLoadingPage({super.key});

  @override
  State<AppLoadingPage> createState() => _AppLoadingPageState();

  @override
  Widget wrappedRoute(BuildContext context) => RepositoryProvider(
        create: (context) => AppLoadingManager(
          context.read<TokenProvider>(),
          context.read<DbManager>(),
        ),
        child: this,
      );
}

class _AppLoadingPageState extends State<AppLoadingPage> {
  @override
  void initState() {
    context.read<AppLoadingManager>().init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Material(
          child: Center(
            child: AlumniLogo(),
          ),
        ),
      );
}
