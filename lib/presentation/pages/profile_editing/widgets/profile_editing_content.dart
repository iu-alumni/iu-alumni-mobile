import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../application/models/profile.dart';
import '../../../blocs/models/profile_editing_state.dart';
import '../../../blocs/profile/profile_editing_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_switch.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/location_dialog.dart';
import '../../../common/widgets/profile_pic.dart';
import '../../../common/widgets/titled_item.dart';
import '../../auth/widgets/year_picker.dart';

class ProfileEditingContent {
  ProfileEditingContent({required this.profile});

  final Profile profile;

  static const _horPadding = EdgeInsets.symmetric(horizontal: 24);

  void _showLocationPicker(BuildContext context, bool currentIsNone) async {
    final location = await LocationDialog.show(context, currentIsNone);
    if (!context.mounted) {
      return;
    }
    context
        .read<ProfileEditingCubit>()
        .update((e) => e.copyWith(location: location));
  }

  void _updateAvatar(BuildContext context) async {
    final image = await context
        .read<ImagePicker>()
        .pickImage(source: ImageSource.gallery);
    if (image == null || !context.mounted) {
      return;
    }
    final bytes = await image.readAsBytes();
    final compressed = await FlutterImageCompress.compressWithList(
      bytes,
      quality: 90,
    );
    final encoded = base64Encode(compressed);
    if (!context.mounted) {
      return;
    }
    context
        .read<ProfileEditingCubit>()
        .update((p) => p.copyWith(avatar: encoded));
  }

  AppBody build(BuildContext context) => AppListBody(
        children: [
          const SizedBox(height: 40),
          BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
            buildWhen: (pr, cu) {
              final p = pr.profile.toNullable();
              final c = cu.profile.toNullable();
              return p?.lastName != c?.lastName ||
                  p?.firstName != c?.firstName ||
                  p?.avatar != c?.avatar;
            },
            builder: (context, ep) {
              final p = ep.profile.toNullable() ?? profile;
              return ProfilePic(
                profile: p,
                edit: () => _updateAvatar(context),
              );
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'First Name',
              child: AppTextField(
                initialText: profile.firstName,
                hintText: 'Ivan',
                onChange: (nn) => context.read<ProfileEditingCubit>().update(
                      (p) => p.copyWith(firstName: nn),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Last Name',
              child: AppTextField(
                initialText: profile.lastName,
                hintText: 'Ivanov',
                onChange: (nn) => context.read<ProfileEditingCubit>().update(
                      (p) => p.copyWith(lastName: nn),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Graduation year',
              child: BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
                buildWhen: (p, c) =>
                    p.profile.map((p) => p.graduationYear) !=
                    c.profile.map((p) => p.graduationYear),
                builder: (context, ep) => AppButton(
                  buttonStyle: AppButtonStyle.gray,
                  onTap: () async {
                    final year = await GraduationYearPicker.show(context);
                    if (year != null && context.mounted) {
                      context
                          .read<ProfileEditingCubit>()
                          .update((p) => p.copyWith(graduationYear: '$year'));
                    }
                  },
                  child: Text(
                    ep.profile.match(
                      () => profile.graduationYear,
                      (s) => s.graduationYear,
                    ),
                    style: AppTextStyles.body,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Biography',
              child: AppTextField(
                initialText: profile.biography,
                hintText: 'What is on your mind?',
                onChange: (nb) => context.read<ProfileEditingCubit>().update(
                      (p) => p.copyWith(biography: nb),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Location',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    buttonStyle: AppButtonStyle.gray,
                    child:
                        BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
                      buildWhen: (p, c) =>
                          p.profile.map((p) => p.location) !=
                          c.profile.map((p) => p.location),
                      builder: (context, ep) => Text(
                        ep.profile.toNullable()?.location ?? 'No location',
                        style: AppTextStyles.actionSB.copyWith(
                          color: ep.profile.toNullable()?.location == null
                              ? AppColors.gray50
                              : AppColors.darkGray,
                        ),
                      ),
                    ),
                    onTap: () => _showLocationPicker(
                      context,
                      context
                              .read<ProfileEditingCubit>()
                              .state
                              .profile
                              .map((p) => p.location)
                              .toNullable() ==
                          null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
                        buildWhen: (p, c) =>
                            p.profile.map((p) => p.showLocation) !=
                            c.profile.map((p) => p.showLocation),
                        builder: (context, ep) => AppSwitch(
                          value: ep.profile
                              .match(() => false, (p) => p.showLocation),
                          onTap: (_) =>
                              context.read<ProfileEditingCubit>().update(
                                    (p) => p.copyWith(
                                      showLocation: !p.showLocation,
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('Show my location', style: AppTextStyles.body),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Telegram',
              child: AppTextField(
                initialText: profile.telegramAlias,
                onChange: (alias) => context
                    .read<ProfileEditingCubit>()
                    .update((p) => p.copyWith(telegramAlias: alias)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const _ErrorText(),
          const SizedBox(height: 16),
        ],
      );
}

class _ErrorText extends StatelessWidget {
  const _ErrorText();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
        buildWhen: (p, c) => p.saveState != c.saveState,
        builder: (context, state) => AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: switch (state.saveState) {
            LoadedStateError(:final error) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40)
                    .copyWith(top: 0),
                child: Text(
                  error,
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.start,
                ),
              ),
            _ => const SizedBox(),
          },
        ),
      );
}
