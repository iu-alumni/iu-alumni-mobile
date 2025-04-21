import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/profile/profile_repository.dart';
import '../../blocs/profile/profile_editing_cubit.dart';
import '../profile/widgets/profile_page_title.dart';
import 'widgets/profile_editing_content.dart';

@RoutePage()
class ProfileEditingPage extends StatefulWidget implements AutoRouteWrapper {
  const ProfileEditingPage({super.key});

  @override
  State<ProfileEditingPage> createState() => _ProfileEditingPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (ctx) => ProfileEditingCubit(ctx.read<ProfileRepository>()),
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
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfilePageTitle(personal: false),
            Expanded(
              child: SafeArea(
                top: false,
                child: BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
                  // Rebuild only on the model appearance
                  buildWhen: (p, c) => p.isNone() != c.isNone(),
                  builder: (context, profile) => profile.match(
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
      );
}
