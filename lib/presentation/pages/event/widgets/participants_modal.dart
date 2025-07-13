import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_button.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/app_scaffold.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/nav_button.dart';

import '../../../../application/models/profile.dart';
import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/profile_pic.dart';
import '../../../router/app_router.gr.dart';

class ParticipantsModal extends StatelessWidget {
  const ParticipantsModal({super.key});

  @override
  Widget build(BuildContext context) => AppScaffold(
    leadingButton: const NavButton(content: NavButtonContent.close),
    title: 'Participants',
    body: AppChildBody(
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<OneEventCubit, OneEventState>(
          buildWhen: (p, c) => p.participants != c.participants,
          builder: (context, state) => switch (state.participants) {
            LoadedStateData(:final data) when data.isEmpty => Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'An error occurred when loading participants',
                style: AppTextStyles.caption,
                textAlign: TextAlign.left,
              ),
            ),
            LoadedStateData(:final data) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: data.map((p) => _ParticipantItem(p: p)).toList(),
            ),
            _ => const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(color: AppColors.gray50),
              ),
            ),
          },
        ),
      ),
    ),
  );
}

class _ParticipantItem extends StatelessWidget {
  const _ParticipantItem({required this.p});

  final Profile p;

  void _onTap(BuildContext context) =>
      context.pushRoute(ProfileRoute(profile: Option.of(p)));

  @override
  Widget build(BuildContext context) => AppButton(
    buttonStyle: AppButtonStyle.text,
    onTap: () => _onTap(context),
    child: Row(
      spacing: 8,
      children: [
        ProfilePic(profile: p, size: 48),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                p.fullName,
                style: AppTextStyles.body,
                textAlign: TextAlign.start,
              ),
              if (p.location case final location?)
                Text(
                  location,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.gray50,
                  ),
                  textAlign: TextAlign.start,
                ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios, color: AppColors.gray50),
      ],
    ),
  );
}
