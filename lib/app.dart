import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'application/repositories/auth/auth_repository.dart';
import 'application/repositories/auth/auth_repository_impl.dart';
import 'application/repositories/events/events_repository.dart';
import 'application/repositories/events/events_repository_impl.dart';
import 'application/repositories/map/map_repository.dart';
import 'application/repositories/map/map_repository_impl.dart';
import 'application/repositories/reporter/reporter.dart';
import 'application/repositories/reporter/reporter_impl.dart';
import 'application/repositories/users/users_repository.dart';
import 'application/repositories/users/users_repository_impl.dart';
import 'data/auth/auth_gateway.dart';
import 'data/auth/auth_gateway_impl.dart';
import 'data/common/dio_options_manager.dart';
import 'data/db/db_manager.dart';
import 'data/db/db_manager_impl.dart';
import 'data/events/events_gateway.dart';
import 'data/events/events_gateway_impl.dart';
import 'data/profile_gateway/profile_gateway.dart';
import 'data/profile_gateway/profile_gateway_impl.dart';
import 'data/token/token_manager.dart';
import 'data/token/token_provider.dart';
import 'data/token/token_provider_impl.dart';
import 'data/users/users_gateway.dart';
import 'data/users/users_gateway_impl.dart';
import 'presentation/blocs/events_list/events_list_cubit.dart';
import 'presentation/blocs/profile/profile_cubit.dart';
import 'presentation/common/constants/app_colors.dart';
import 'presentation/managers/app_loading_manager.dart';
import 'presentation/router/app_observer.dart';
import 'presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          // --- SERVICES ---
          RepositoryProvider(create: (_) => const FlutterSecureStorage()),
          RepositoryProvider(create: (_) => ImagePicker()),
          RepositoryProvider<DbManager>(create: (_) => DbManagerImpl()),
          RepositoryProvider(
            create: (context) => TokenManager(
              context.read<FlutterSecureStorage>(),
            ),
          ),
          RepositoryProvider<TokenProvider>(
            create: (context) => TokenProviderImpl(
              context.read<TokenManager>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => DioOptionsManager(
              context.read<TokenProvider>(),
            ),
          ),
          RepositoryProvider(
            create: (_) => Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
              ),
            ),
          ),
          RepositoryProvider(create: (_) => const Uuid()),
          // --- GATEWAYS ---
          RepositoryProvider<EventsGateway>(
            create: (context) => EventsGatewayImpl(
              context.read<Dio>(),
              context.read<DioOptionsManager>(),
            ),
          ),
          RepositoryProvider<AuthGateway>(
            create: (context) => AuthGatewayImpl(
              context.read<Dio>(),
              context.read<TokenManager>(),
              context.read<DioOptionsManager>(),
            ),
          ),
          RepositoryProvider<ProfileGateway>(
            create: (context) => ProfileGatewayImpl(
              context.read<Dio>(),
              context.read<DioOptionsManager>(),
            ),
          ),
          RepositoryProvider<UsersGateway>(
            create: (context) => UsersGatewayImpl(
              context.read<Dio>(),
              context.read<DioOptionsManager>(),
            ),
          ),
          // --- REPOSITORIES ---
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepositoryImpl(
              context.read<AuthGateway>(),
            ),
          ),
          RepositoryProvider<UsersRepository>(
            create: (context) => UsersRepositoryImpl(
              context.read<ProfileGateway>(),
              context.read<TokenProvider>(),
              context.read<UsersGateway>(),
            ),
          ),
          RepositoryProvider<EventsRepository>(
            create: (context) => EventsRepositoryImpl(
              context.read<Uuid>(),
              context.read<EventsGateway>(),
              context.read<UsersRepository>(),
            ),
          ),
          RepositoryProvider<Reporter>(
            create: (context) => ReporterImpl(context.read<UsersRepository>()),
          ),
          RepositoryProvider(
            create: (context) => AppLoadingManager(
              context.read<TokenProvider>(),
              context.read<DbManager>(),
              context.read<Reporter>(),
            ),
          ),
          RepositoryProvider<MapRepository>(
            create: (context) => MapRepositoryImpl(
              context.read<DbManager>(),
              context.read<UsersRepository>(),
              context.read<EventsRepository>(),
            ),
          ),
          // --- BLOCs ---
          BlocProvider(
            create: (context) => EventsListCubit(
              context.read<EventsRepository>(),
              context.read<UsersRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => ProfileCubit(
              ctx.read<UsersRepository>(),
              ctx.read<EventsRepository>(),
            ),
          ),
        ],
        child: Builder(
          builder: (context) => MaterialApp.router(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                surface: Colors.white,
              ),
              useMaterial3: true,
            ),
            routerConfig: AppRouter().config(
              navigatorObservers: () => [
                AppObserver(context.read<Reporter>()),
              ],
            ),
          ),
        ),
      );
}
