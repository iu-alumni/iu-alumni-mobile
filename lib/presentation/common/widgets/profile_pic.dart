import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../application/models/profile.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    required this.profile,
    this.edit,
    this.onTap,
    this.size,
    super.key,
  });

  final Profile profile;
  // null means the image is not edited and the editing overlay is not shown
  final void Function()? edit;
  // On tap action. Editing creates an overlay disallowing the `onTap` action
  final void Function()? onTap;
  // The default size is 90x90
  final double? size;

  @override
  Widget build(BuildContext context) {
    final imgSize = size ?? 90;
    final radius = imgSize / 2;
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(radius),
            child: InkWell(
              onTap: onTap,
              child: switch (profile.avatar) {
                final image? => Image.memory(
                    base64Decode(image),
                    width: imgSize,
                    height: imgSize,
                    fit: BoxFit.cover,
                  ),
                _ => Container(
                    width: imgSize,
                    height: imgSize,
                    decoration: const BoxDecoration(
                      color: AppColors.lightPrimary,
                    ),
                    child: Center(
                      child: Text(
                        '${profile.firstName.characters.first}${profile.lastName.characters.first}',
                        style: AppTextStyles.h2.copyWith(fontSize: radius),
                      ),
                    ),
                  ),
              },
            ),
          ),
          if (edit case final fun?)
            Container(
              width: imgSize,
              height: imgSize,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Center(
                child: IconButton(
                  onPressed: fun,
                  icon: const Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
