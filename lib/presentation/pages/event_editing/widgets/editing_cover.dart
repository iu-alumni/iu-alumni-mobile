import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../application/models/event.dart';
import '../../../blocs/one_event/one_event_cubit.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/event_cover.dart';

class EditingCover extends StatelessWidget {
  const EditingCover({super.key});

  void _pickCover(BuildContext context) async {
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
      minWidth: 1080,
    );
    final encoded = base64Encode(compressed);
    if (!context.mounted) {
      return;
    }
    context
        .read<OneEventCubit>()
        .modify((event) => event.copyWith(coverBytes: encoded));
  }

  bool _buildWhen(Option<EventModel> p, Option<EventModel> c) =>
      switch ((p, c)) {
        (
          final Some<EventModel> ps,
          final Some<EventModel> cs,
        ) =>
          ps.value.coverBytes != cs.value.coverBytes,
        _ => false,
      };

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OneEventCubit, OneEventState>(
        buildWhen: _buildWhen,
        builder: (context, event) => EventCover(
          imageBytes: event.toNullable()?.coverBytes,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppButton(
                onTap: () => _pickCover(context),
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
