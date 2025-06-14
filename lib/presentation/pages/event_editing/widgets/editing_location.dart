import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../blocs/models/one_event_state.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/location_dialog.dart';
import '../../../common/widgets/titled_item.dart';

class EditingLocation extends StatelessWidget {
  const EditingLocation({super.key});

  Option<String?> _location(OneEventState state) => state.event.flatMap(
        (e) => e.onlineEvent ? const None() : Option.of(e.location),
      );

  void _showLocationPicker(BuildContext context, bool currentIsNone) async {
    final location = await LocationDialog.show(context, currentIsNone);
    if (!context.mounted) {
      return;
    }
    context.read<OneEventCubit>().modify((e) => e.copyWith(location: location));
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OneEventCubit, OneEventState>(
        builder: (context, event) => AnimatedSize(
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 300),
          child: _location(event).match(
            () => const SizedBox(),
            (current) => TitledItem(
              icon: Icons.location_pin,
              title: 'Location',
              child: AppButton(
                buttonStyle: AppButtonStyle.input,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    current ?? 'No location',
                    style: AppTextStyles.buttonText.copyWith(
                      color:
                          current == null ? AppColors.blueGray : Colors.black,
                    ),
                  ),
                ),
                onTap: () => _showLocationPicker(context, current == null),
              ),
            ),
          ),
        ),
      );
}
