import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../router/app_router.gr.dart';

class ProfilePageTitle extends StatelessWidget {
  const ProfilePageTitle({required this.personal, super.key});

  final bool personal;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Profile',
                style: AppTextStyles.h2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (personal) ...[
              IconButton.filled(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                ),
                onPressed: () async {
                  await context.pushRoute(const ProfileEditingRoute());
                  if (context.mounted) {
                    context.read<ProfileCubit>().loadProfile();
                  }
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.error),
                ),
                onPressed: () {
                  context.read<ProfileCubit>().logout();
                  context.router.replaceAll([const AuthRoute()]);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ]
          ],
        ),
      );
}
