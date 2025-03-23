import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'application/repositories/auth/auth_repository.dart';
import 'application/repositories/auth/auth_repository_impl.dart';
import 'application/repositories/events/events_repository.dart';
import 'application/repositories/events/events_repository_impl.dart';
import 'data/auth/auth_gateway.dart';
import 'data/auth/auth_gateway_impl.dart';
import 'data/events/events_gateway.dart';
import 'data/events/events_gateway_impl.dart';
import 'data/token/token_provider.dart';
import 'presentation/blocs/events_list/events_list_cubit.dart';
import 'presentation/common/constants/app_colors.dart';
import 'presentation/router/config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          // --- SERVICES ---
          RepositoryProvider(create: (_) => TokenProvider()),
          RepositoryProvider(
            create: (_) => Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
              ),
            ),
          ),
          RepositoryProvider(create: (_) => const Uuid()),
          RepositoryProvider<EventsGateway>(
            create: (context) => EventsGatewayImpl(
              context.read<Dio>(),
              context.read<TokenProvider>(),
            ),
          ),
          RepositoryProvider<AuthGateway>(
            create: (context) => AuthGatewayImpl(
              context.read<Dio>(),
              context.read<TokenProvider>(),
            ),
          ),
          // --- REPOSITORIES ---
          RepositoryProvider<EventsRepository>(
            create: (context) => EventsRepositoryImpl(
              context.read<Uuid>(),
              context.read<EventsGateway>(),
            ),
          ),
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepositoryImpl(
              context.read<AuthGateway>(),
            ),
          ),
          // --- BLOCs ---
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
