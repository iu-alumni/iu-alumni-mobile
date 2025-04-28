import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';
import '../../../router/app_router.gr.dart';

class ProfilePageTitle extends StatelessWidget {
  const ProfilePageTitle({required this.personal, super.key});

  final bool personal;

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 40,
          ).copyWith(bottom: 0),
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
                AppButton(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () async {
                    await context.pushRoute(const ProfileEditingRoute());
                    if (context.mounted) {
                      context.read<ProfileCubit>().loadProfile();
                    }
                  },
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
                  onTap: () {
                    context.read<ProfileCubit>().logout();
                    context.router.replaceAll([const AuthRoute()]);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      );
}
