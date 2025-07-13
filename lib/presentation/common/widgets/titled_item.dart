import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';

class TitledItem extends StatelessWidget {
  const TitledItem({
    required this.title,
    required this.child,
    this.titlePadding = EdgeInsets.zero,
    super.key,
  });

  final String title;
  final Widget child;
  final EdgeInsets titlePadding;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: titlePadding,
        child: Text(
          title,
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.start,
        ),
      ),
      const SizedBox(height: 8),
      child,
    ],
  );
}
