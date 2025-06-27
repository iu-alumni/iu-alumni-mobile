import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';
import 'nav_button.dart';

class EventCover extends StatelessWidget {
  const EventCover({
    required this.child,
    required this.imageBytes,
    this.title,
    super.key,
  });

  final String? title;
  final Widget child;
  final String? imageBytes;

  @override
  Widget build(BuildContext context) {
    final maybeTitle = title;
    final horPadding = const EdgeInsets.symmetric(horizontal: 16);
    return SizedBox(
      height: 324,
      child: Stack(
        children: [
          if (imageBytes case final bytes? when bytes.isNotEmpty)
            Positioned.fill(
              bottom: 24,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Image.memory(base64Decode(bytes), fit: BoxFit.cover),
              ),
            ),
          const Positioned.fill(
            bottom: 24,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black12, Colors.black54],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: horPadding,
                    child: const Row(
                      children: [
                        NavButton(style: NavButtonStyle.semitransparent),
                        Spacer(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (maybeTitle != null)
                    Padding(
                      padding: horPadding,
                      child: Text(
                        maybeTitle,
                        style: AppTextStyles.largeTitle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Padding(padding: horPadding, child: child),
                  // Padding(
                  //   padding: horPadding,
                  //   child: Opacity(
                  //     opacity: maybeTitle != null ? 1 : 0,
                  //     child: Text(
                  //       maybeTitle ?? 'title',
                  //       style: AppTextStyles.h2.copyWith(color: Colors.white),
                  //       textAlign: TextAlign.start,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 2),
                  // Padding(
                  //   padding: horPadding,
                  //   child: Opacity(
                  //     opacity: maybeLocation != null ? 1 : 0,
                  //     child: Row(
                  //       children: [
                  //         Icon(Icons.location_pin, color: secondaryWhite),
                  //         const SizedBox(width: 8),
                  //         Expanded(
                  //           child: Text(
                  //             maybeLocation ?? 'location',
                  //             style: AppTextStyles.h4
                  //                 .copyWith(color: secondaryWhite),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 140),
                  // child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
