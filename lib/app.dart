import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'application/repositories/events/events_repository.dart';
import 'application/repositories/events/events_repository_impl.dart';
import 'data/events/events_gateway.dart';
import 'data/events/events_gateway_impl.dart';
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
          RepositoryProvider(create: (_) => const Uuid()),
          RepositoryProvider<EventsGateway>(
            create: (context) => EventsGatewayImpl(
              context.read<Dio>(),
            ),
          ),
          // --- REPOSITORIES ---
          RepositoryProvider<EventsRepository>(
            create: (context) => EventsRepositoryImpl(
              context.read<Uuid>(),
              context.read<EventsGateway>()
            ),
          ),
          // --- BLOCS ---
          BlocProvider(create: (_) => RootPageCubit()),
          BlocProvider(
            create: (context) => EventsListCubit(
              context.read<EventsRepository>(),
            ),
          ),
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
