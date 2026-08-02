import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../application/models/event.dart';
import '../../../application/repositories/events/events_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../router/app_router.gr.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    required this.event,
    this.color = AppColors.gray90,
    super.key,
  });

  final Color color;
  final EventModel event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late final _formatter = DateFormat('dd.MM.yyyy, HH:mm');
  late Future<String?> _cover;

  @override
  void initState() {
    super.initState();
    _cover = widget.event.coverBytes != null
        ? Future.value(widget.event.coverBytes)
        : context.read<EventsRepository>().getEventCover(widget.event.eventId);
  }

  @override
  void didUpdateWidget(covariant EventCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.event.eventId != widget.event.eventId ||
        oldWidget.event.coverBytes != widget.event.coverBytes) {
      _cover = widget.event.coverBytes != null
          ? Future.value(widget.event.coverBytes)
          : context.read<EventsRepository>().getEventCover(
              widget.event.eventId,
            );
    }
  }

  void _openEvent() {
    context.read<Reporter>().reportOpenEvent(
      widget.event,
      AppLocation.eventsTab,
    );
    context.pushRoute(EventRoute(eventId: widget.event.eventId));
  }

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(24),
    color: widget.color,
    child: InkWell(
      onTap: _openEvent,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String?>(
              future: _cover,
              builder: (context, snapshot) {
                final bytes = snapshot.data;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: bytes == null || bytes.isEmpty
                        ? const ColoredBox(
                            color: Colors.white38,
                            child: Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: Colors.black26,
                              ),
                            ),
                          )
                        : Image.memory(
                            base64Decode(bytes),
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                          ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8).copyWith(top: 16),
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.event.title case final title?
                      when title.isNotEmpty) ...[
                    Text(
                      title,
                      style: AppTextStyles.subtitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    // Additional 6px margin
                    const SizedBox(height: 6),
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
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  if (widget.event.location case final location?
                      when location.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.location_pin, color: Colors.black38),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.black38,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  if (widget.event.pendingApproval)
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.black38),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Pending approval',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.black38,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
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
