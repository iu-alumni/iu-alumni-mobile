import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/profile/profile_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import 'widgets/profile_content.dart';
import 'widgets/profile_page_title.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileCubit>().loadProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfilePageTitle(showEditingIcon: true),
            Expanded(
              child: SafeArea(
                top: false,
                child: BlocBuilder<ProfileCubit, ProfileState>(
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
              ),
            ),
          ],
        ),
      );
}
