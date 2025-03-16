import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../application/models/event.dart';
import '../../../../util/gap.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../router/config.gr.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    required this.cardColor,
    required this.textColor,
    required this.event,
    super.key,
  });

  final Color cardColor;
  final Color textColor;
  final EventModel event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late final _formatter = DateFormat('hh:mm dd.MM.yyyy');
  late final _secondaryTextColor = widget.textColor.withValues(alpha: 0.8);

  @override
  Widget build(BuildContext context) => Material(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(4),
        shadowColor: Colors.black26,
        elevation: 4,
        child: InkWell(
          onTap: () => context.pushRoute(
            EventRoute(eventId: widget.event.eventId),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  // TODO do something with empty titles like default title 
                  widget.event.title ?? '',
                  style: AppTextStyles.h6.copyWith(color: widget.textColor),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: widget.textColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatter.format(widget.event.occurringAt),
                      style: AppTextStyles.caption.copyWith(
                        color: _secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                if (widget.event.location case final location?)
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: widget.textColor),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: AppTextStyles.caption.copyWith(
                          color: _secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                if (widget.event.description case final desc?)
                  Text(
                    desc,
                    style: AppTextStyles.smallBody
                        .copyWith(color: widget.textColor),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                  ),
              ].gap(const SizedBox(height: 2)),
            ),
          ),
        ),
      );
}
