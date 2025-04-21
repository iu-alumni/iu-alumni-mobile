import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../application/models/profile.dart';
import '../../blocs/profile/profile_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import 'widgets/profile_content.dart';
import 'widgets/profile_page_title.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({this.profile = const None(), super.key});

  final Option<Profile> profile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // The profile is the user's own
    if (widget.profile.isNone()) {
      context.read<ProfileCubit>().loadProfile();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfilePageTitle(showEditingIcon: widget.profile.isNone()),
            Expanded(
              child: SafeArea(
                top: false,
                child: widget.profile.match(
                  () => BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, profile) => switch (profile) {
                      ProfileData(:final data) => SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ProfileContent(profile: data),
                        ),
                      ProfileError e => Center(
                          child: Text(
                            e.error,
                            style: AppTextStyles.caption,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      _ => const Center(
                          child: CircularProgressIndicator(),
                        ),
                    },
                  ),
                  (p) => ProfileContent(profile: p),
                ),
              ),
            ),
          ],
        ),
      );
}
