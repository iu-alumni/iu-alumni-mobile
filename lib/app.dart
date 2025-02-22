import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/blocs/events_list/events_list_cubit.dart';
import 'presentation/blocs/root/root_page_cubit.dart';
import 'presentation/common/constants/app_colors.dart';
import 'presentation/router/config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          // --- SERVICES ---
          RepositoryProvider(create: (_) => Dio()),
          // --- REPOSITORIES ---
          // --- BLOCS ---
          BlocProvider(create: (_) => RootPageCubit()),
          BlocProvider(create: (_) => EventsListCubit()),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              surface: Colors.white,
            ),
            useMaterial3: true,
          ),
          routerConfig: AppRouter().config(),
        ),
      );
}
