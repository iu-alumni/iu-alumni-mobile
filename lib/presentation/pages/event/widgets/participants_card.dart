import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/profile_pic.dart';
import 'participants_modal.dart';

class ParticipantsCard extends StatelessWidget {
  const ParticipantsCard({super.key});

  void _showParticipants(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => BlocProvider.value(
          value: context.read<OneEventCubit>(),
          child: const ParticipantsModal(),
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        color: AppColors.gray90,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showParticipants(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Participants',
                    style: AppTextStyles.subtitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                BlocBuilder<OneEventCubit, OneEventState>(
                  buildWhen: (p, c) => p.participants != c.participants,
                  builder: (context, state) => switch (state.participants) {
                    LoadedStateData(:final data) when data.isEmpty =>
                      const Icon(
                        Icons.error_rounded,
                        color: AppColors.error,
                      ),
                    LoadedStateData(:final data) => _StackedRow(
                        profiles: [
                          for (final p in data)
                            ProfilePic(profile: p, size: 48),
                        ],
                      ),
                    _ => const Align(
                        alignment: Alignment.centerLeft,
                        child: CircularProgressIndicator(
                          color: AppColors.gray50,
                        ),
                      )
                  },
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.gray50,
                ),
              ],
            ),
          ),
        ),
      );
}

class _StackedRow extends StatelessWidget {
  const _StackedRow({required this.profiles});

  final List<Widget> profiles;

  @override
  Widget build(BuildContext context) {
    if (profiles.isEmpty) {
      return const SizedBox();
    }
    final widgets = profiles.length <= 6
        ? profiles
        : [
            ...profiles.take(5),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.darkGray,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                '+${profiles.length - 5}',
                style: AppTextStyles.caption.copyWith(color: Colors.white),
              ),
            ),
          ];
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: 48, maxWidth: 36 + widgets.length * 12),
      child: Stack(
        children: [
          ...[
            for (final (i, w) in widgets.indexed)
              Positioned(left: i * 36, child: w),
          ],
        ],
      ),
    );
  }
}
