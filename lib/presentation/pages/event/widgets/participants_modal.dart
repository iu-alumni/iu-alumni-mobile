import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

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
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
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
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Participants',
                          style: AppTextStyles.subtitle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (final p in data) _ParticipantItem(p: p),
                      const SizedBox(height: 24),
                    ],
                  ),
                _ => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(
                        color: AppColors.gray50,
                      ),
                    ),
                  )
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
  Widget build(BuildContext context) => InkWell(
        onTap: () => _onTap(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              ProfilePic(profile: p, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${p.firstName} ${p.lastName}',
                      style: AppTextStyles.actionSB,
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
            ],
          ),
        ),
      );
}
