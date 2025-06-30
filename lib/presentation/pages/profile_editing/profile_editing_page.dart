import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/reporter/reporter.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../blocs/models/profile_editing_state.dart';
import '../../blocs/profile/profile_editing_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_scaffold.dart';
import 'widgets/profile_editing_content.dart';

@RoutePage()
class ProfileEditingPage extends StatefulWidget implements AutoRouteWrapper {
  const ProfileEditingPage({super.key});

  @override
  State<ProfileEditingPage> createState() => _ProfileEditingPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (ctx) => ProfileEditingCubit(
          ctx.read<UsersRepository>(),
          ctx.read<Reporter>(),
        ),
        child: this,
      );
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  @override
  void initState() {
    context.read<ProfileEditingCubit>().loadProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProfileEditingCubit, ProfileEditingState>(
        listenWhen: (p, c) => p.saveState != c.saveState,
        listener: (context, state) => switch (state.saveState) {
          LoadedStateData() => context.maybePop(),
          _ => null,
        },
        buildWhen: (p, c) => p.profile.isNone() != c.profile.isNone(),
        builder: (context, state) => AppScaffold(
          title: 'Editing profile',
          actions: [
            AppButton(
              is48Height: true,
              onTap: context.read<ProfileEditingCubit>().save,
              child: Text(
                'Save',
                style: AppTextStyles.actionSB.copyWith(color: Colors.white),
              ),
            ),
          ],
          body: state.profile.match(
              () => const AppChildBody(
                    child: Center(child: CircularProgressIndicator()),
                  ),
              (p) => ProfileEditingContent(profile: p).build(context)),
        ),
      );
}
