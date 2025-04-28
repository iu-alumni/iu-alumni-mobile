import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/users/users_repository.dart';
import '../../blocs/models/profile_editing_state.dart';
import '../../blocs/profile/profile_cubit.dart';
import '../../blocs/profile/profile_editing_cubit.dart';
import '../../common/models/loaded_state.dart';
import '../profile/widgets/profile_page_title.dart';
import 'widgets/profile_editing_content.dart';

@RoutePage()
class ProfileEditingPage extends StatefulWidget implements AutoRouteWrapper {
  const ProfileEditingPage({super.key});

  @override
  State<ProfileEditingPage> createState() => _ProfileEditingPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (ctx) => ProfileEditingCubit(ctx.read<UsersRepository>()),
        child: this,
      );
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  @override
  void initState() {
    context.read<ProfileEditingCubit>().loadProfile();
    super.initState();
  }

  void _updateAndLeave() {
    context.read<ProfileCubit>().loadProfile();
    context.maybePop();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProfileEditingCubit, ProfileEditingState>(
        listenWhen: (p, c) => p.saveState != c.saveState,
        listener: (context, state) => switch (state.saveState) {
          LoadedStateData() => _updateAndLeave(),
          _ => null,
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfilePageTitle(personal: false),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
                    // Rebuild only on the model appearance
                    buildWhen: (p, c) =>
                        p.profile.isNone() != c.profile.isNone(),
                    builder: (context, profile) => profile.profile.match(
                      () => const Center(child: CircularProgressIndicator()),
                      (p) => SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ProfileEditingContent(profile: p),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
