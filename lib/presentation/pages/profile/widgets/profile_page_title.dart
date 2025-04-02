import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../router/app_router.gr.dart';

class ProfilePageTitle extends StatelessWidget {
  const ProfilePageTitle({required this.showEditingIcon, super.key});

  final bool showEditingIcon;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profile',
              style: AppTextStyles.h2,
              textAlign: TextAlign.start,
            ),
            if (showEditingIcon)
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
              )
            else
              const SizedBox(),
          ],
        ),
      );
}
