import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/repositories/reporter/reporter.dart';
import '../../../blocs/models/profile_state.dart';
import '../../../blocs/profile/profile_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/back_button.dart';
import '../../../common/widgets/button.dart';
import '../../../router/app_router.gr.dart';

class ProfilePageTitle extends StatelessWidget {
  const ProfilePageTitle({required this.showBackButton, super.key});

  final bool showBackButton;

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
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 40,
          ).copyWith(bottom: 0),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showBackButton) ...[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Transform.translate(
                      offset: const Offset(-16, 0),
                      child: const AppSmallButton(),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Profile',
                        style: AppTextStyles.h2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (state.myOwn) ...[
                      AppButton(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => _editTap(context),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      AppButton(
                        buttonStyle: AppButtonStyle.destructive,
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => _logout(context),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.logout, color: Colors.white),
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
