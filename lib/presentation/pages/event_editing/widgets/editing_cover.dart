import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/event_cover.dart';

class EditingCover extends StatelessWidget {
  const EditingCover({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OneEventCubit, OneEventState>(
        builder: (context, event) => EventCover(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Button(
                onTap: () {},
                buttonStyle: AppButtonStyle.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Choose cover',
                    style: AppTextStyles.buttonText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
