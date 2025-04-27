import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../../application/models/profile.dart';
import '../../../blocs/profile/profile_editing_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/location_dialog.dart';
import '../../../common/widgets/titled_item.dart';
import '../../root/root_page.dart';
import '../../verification/widgets/year_picker.dart';

class ProfileEditingContent extends StatefulWidget {
  const ProfileEditingContent({required this.profile, super.key});

  final Profile profile;

  @override
  State<ProfileEditingContent> createState() => _ProfileEditingContentState();
}

class _ProfileEditingContentState extends State<ProfileEditingContent> {
  static const _horPadding = EdgeInsets.symmetric(horizontal: 40);

  late final ProfileEditingCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<ProfileEditingCubit>();
    super.initState();
  }

  void _showLocationPicker(BuildContext context, bool currentIsNone) async {
    final location = await LocationDialog.show(context, currentIsNone);
    if (!context.mounted) {
      return;
    }
    _cubit.update((e) => e.copyWith(location: location));
  }

  void _onSave() {
    context.read<ProfileEditingCubit>().save();
    context.maybePop();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'First Name',
              child: AppTextField(
                initialText: widget.profile.firstName,
                hintText: 'Ivan',
                onChange: (nn) => _cubit.update(
                  (p) => p.copyWith(firstName: nn),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Last Name',
              child: AppTextField(
                initialText: widget.profile.lastName,
                hintText: 'Ivanov',
                onChange: (nn) => _cubit.update(
                  (p) => p.copyWith(lastName: nn),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Graduation year',
              child: BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
                buildWhen: (p, c) =>
                    p.map((p) => p.graduationYear) !=
                    c.map((p) => p.graduationYear),
                builder: (context, ep) => AppButton(
                  buttonStyle: AppButtonStyle.input,
                  onTap: () async {
                    final year = await GraduationYearPicker.show(context);
                    if (year != null) {
                      _cubit.update((p) => p.copyWith(graduationYear: '$year'));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      ep.match(
                        () => widget.profile.graduationYear,
                        (s) => s.graduationYear,
                      ),
                      style: AppTextStyles.body,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Biography',
              child: AppTextField(
                initialText: widget.profile.biography,
                hintText: 'What is on your mind?',
                onChange: (nb) => _cubit.update(
                  (p) => p.copyWith(biography: nb),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Location',
              child: AppButton(
                buttonStyle: AppButtonStyle.input,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
                    buildWhen: (p, c) =>
                        p.map((p) => p.location) != c.map((p) => p.location),
                    builder: (context, ep) => Text(
                      ep.toNullable()?.location ?? 'No location',
                      style: AppTextStyles.buttonText.copyWith(
                        color: switch (ep) {
                          Some(value: Profile(location: final _?)) =>
                            Colors.black,
                          _ => AppColors.blueGray,
                        },
                      ),
                    ),
                  ),
                ),
                onTap: () => _showLocationPicker(
                  context,
                  context
                          .read<ProfileEditingCubit>()
                          .state
                          .map((p) => p.location)
                          .toNullable() ==
                      null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: _horPadding,
            child: TitledItem(
              title: 'Telegram',
              child: AppTextField(
                initialText: widget.profile.telegramAlias,
                onChange: (alias) => context
                    .read<ProfileEditingCubit>()
                    .update((p) => p.copyWith(telegramAlias: alias)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: _horPadding,
            child: AppButton(
              onTap: _onSave,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Done',
                  style: AppTextStyles.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: RootPage.navigationBarHeight + 16),
        ],
      );
}
