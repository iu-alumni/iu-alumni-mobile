import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/models/profile.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../blocs/models/profile_state.dart';
import '../../blocs/profile/profile_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_scaffold.dart';
import '../../router/app_router.gr.dart';
import 'widgets/profile_content.dart';

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

  void _editTap(BuildContext context) async {
    context.read<Reporter>().reportEditProfileTap(AppLocation.profileScreen);
    await context.pushRoute(const ProfileEditingRoute());
    if (context.mounted) {
      context.read<ProfileCubit>().updateProfileData();
    }
  }

  void _logout(BuildContext context) async {
    context.read<Reporter>().reportUnauthorize(AppLocation.profileScreen);
    context.read<ProfileCubit>().logout();
    context.router.replaceAll([const AuthRoute()]);
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (p, c) => p.profile != c.profile,
        listener: (context, state) {
          _cubit.loadOwnedEvents();
          _cubit.loadParticipatedEvents();
        },
        builder: (context, state) => AppScaffold(
          title: 'Profile',
          leadingButton: state.myOwn
              ? AppButton(
                  is48Height: true,
                  buttonStyle: AppButtonStyle.secondary,
                  onTap: () => _logout(context),
                  child: Text(
                    'Logout',
                    style: AppTextStyles.actionM.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
          actions: [
            if (state.myOwn)
              AppButton(
                is48Height: true,
                onTap: () => _editTap(context),
                child: Text(
                  'Edit',
                  style: AppTextStyles.actionSB.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
          body: switch (state.profile) {
            LoadedStateData(:final data) => ProfileContent(
                profile: data,
                personal: state.myOwn,
              ).build(context),
            LoadedStateError e => AppChildBody(
                child: Center(
                  child: Text(
                    e.error,
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            _ => const AppChildBody(
                child: Center(child: AppLoader(inCard: true)),
              ),
          },
        ),
      );
}
