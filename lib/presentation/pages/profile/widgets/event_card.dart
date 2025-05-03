import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../application/models/event.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../router/app_router.gr.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.event, super.key});

  final EventModel event;

  void _onTap(BuildContext context) => context.pushRoute(
        EventRoute(eventId: event.eventId),
      );

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 220,
        height: 150,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _onTap(context),
            child: Stack(
              children: [
                Positioned.fill(
                  child: switch (event.coverBytes) {
                    final image? =>
                      Image.memory(base64Decode(image), fit: BoxFit.cover),
                    _ => const ColoredBox(color: AppColors.darkGray),
                  },
                ),
                const Positioned.fill(child: ColoredBox(color: Colors.black45)),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        if (event.title case final title?)
                          Text(
                            title,
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        if (event.location case final location?
                            when location.isNotEmpty)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                location,
                                style: AppTextStyles.smallBody
                                    .copyWith(color: Colors.white70),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
