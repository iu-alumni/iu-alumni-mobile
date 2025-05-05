import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/models/profile.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../blocs/models/profile_state.dart';
import '../../blocs/profile/profile_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import 'widgets/profile_content.dart';
import 'widgets/profile_page_title.dart';

@RoutePage()
class ProfilePage extends StatefulWidget implements AutoRouteWrapper {
  const ProfilePage({this.profile = const None(), super.key});

  final Option<Profile> profile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (ctx) => ProfileCubit(
          ctx.read<UsersRepository>(),
          ctx.read<EventsRepository>(),
        ),
        child: this,
      );
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<ProfileCubit>();
    _cubit.loadProfile(widget.profile);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (p, c) => p.profile != c.profile,
        listener: (context, state) {
          _cubit.loadOwnedEvents();
          _cubit.loadParticipatedEvents();
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfilePageTitle(),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    buildWhen: (p, c) => p.profile != c.profile,
                    builder: (context, profile) => switch (profile.profile) {
                      LoadedStateData(:final data) => SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ProfileContent(
                            profile: data,
                            personal: profile.myOwn,
                          ),
                        ),
                      LoadedStateError e => Center(
                          child: Text(
                            e.error,
                            style: AppTextStyles.caption,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      _ => const Center(child: CircularProgressIndicator()),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
