import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../application/models/event.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../router/app_router.gr.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class EventCard extends StatefulWidget {
  const EventCard(
      {required this.event, this.color = AppColors.gray90, super.key});

  final Color color;
  final EventModel event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late final _formatter = DateFormat('hh:mm dd.MM.yyyy');

  void _openEvent() {
    context
        .read<Reporter>()
        .reportOpenEvent(widget.event, AppLocation.eventsTab);
    context.pushRoute(EventRoute(eventId: widget.event.eventId));
  }

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(24),
        color: widget.color,
        child: InkWell(
          onTap: _openEvent,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.event.coverBytes case final bytes?
                    when bytes.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.memory(
                        base64Decode(bytes),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8).copyWith(top: 16),
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.event.title case final title?) ...[
                        Text(
                          title,
                          style: AppTextStyles.subtitle,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        // Additional 6px margin
                        const SizedBox(height: 6)
                      ],
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _formatter.format(widget.event.occurringAt),
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.black38,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (widget.event.location case final location?)
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: Colors.black38,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                location,
                                style: AppTextStyles.caption.copyWith(
                                  color: Colors.black38,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
