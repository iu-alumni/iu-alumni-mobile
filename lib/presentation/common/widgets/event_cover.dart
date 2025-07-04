import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';
import 'back_button.dart';

class EventCover extends StatelessWidget {
  const EventCover({
    required this.child,
    required this.imageBytes,
    this.title,
    this.location,
    super.key,
  });

  final String? title;
  final String? location;
  final Widget child;
  final String? imageBytes;

  @override
  Widget build(BuildContext context) {
    final maybeTitle = title;
    final maybeLocation = location;
    final horPadding = const EdgeInsets.symmetric(horizontal: 24);
    final secondaryWhite = Colors.white.withValues(alpha: 0.5);
    return Stack(
      children: [
        if (imageBytes case final bytes? when bytes.isNotEmpty)
          Positioned.fill(
            child: Image.memory(
              base64Decode(bytes),
              fit: BoxFit.cover,
            ),
          ),
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black12.withAlpha(0), Colors.white],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 24,
              ),
            ],
          ),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.topLeft,
                child: AppSmallButton(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: horPadding,
                child: Opacity(
                  opacity: maybeTitle != null ? 1 : 0,
                  child: Text(
                    maybeTitle ?? 'title',
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: horPadding,
                child: Opacity(
                  opacity: maybeLocation != null ? 1 : 0,
                  child: Row(
                    children: [
                      Icon(Icons.location_pin, color: secondaryWhite),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          maybeLocation ?? 'location',
                          style:
                              AppTextStyles.h4.copyWith(color: secondaryWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 140),
              child,
            ],
          ),
        ),
      ],
    );
  }
}
