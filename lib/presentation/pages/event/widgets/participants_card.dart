import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_alumni_mobile/presentation/common/widgets/stacked_row.dart';

import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import 'participants_modal.dart';

class ParticipantsCard extends StatelessWidget {
  const ParticipantsCard({super.key});

  void _showParticipants(BuildContext context) => showCupertinoSheet(
    context: context,
    pageBuilder: (_) => BlocProvider.value(
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
                LoadedStateData(:final data) when data.isEmpty => const Icon(
                  Icons.error_rounded,
                  color: AppColors.error,
                ),
                LoadedStateData(:final data) => StackedRow(profiles: data),
                _ => const Align(
                  alignment: Alignment.centerLeft,
                  child: CircularProgressIndicator(color: AppColors.gray50),
                ),
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
