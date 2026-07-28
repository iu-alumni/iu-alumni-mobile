import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../application/models/notification.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({required this.notification, super.key});

  final NotificationModel notification;

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _expanded = false;
  late final _formatter = DateFormat('dd.MM.yyyy, HH:mm');

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(16),
    // Unread notifications render darker so they stand out from the
    // already-read ones the panel keeps showing alongside them.
    color: widget.notification.read ? AppColors.gray90 : AppColors.gray80,
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => setState(() => _expanded = !_expanded),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (!widget.notification.read)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                const Icon(Icons.event_outlined, color: Colors.black38),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'An event is happening near you soon',
                    style: AppTextStyles.body,
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.black38,
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: _expanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Text(
                            widget.notification.title,
                            style: AppTextStyles.subtitle,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 18,
                                color: Colors.black38,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _formatter.format(widget.notification.datetime),
                                style: AppTextStyles.caption.copyWith(
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                size: 18,
                                color: Colors.black38,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.notification.location,
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
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    ),
  );
}
