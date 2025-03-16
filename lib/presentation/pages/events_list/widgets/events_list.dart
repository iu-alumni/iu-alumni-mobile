import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../application/models/event.dart';
import '../../../common/constants/app_colors.dart';
import '../../root/root_page.dart';
import 'event_card.dart';

class EventsList extends StatefulWidget {
  const EventsList({required this.events, super.key});

  final IList<EventModel> events;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  static const _innoColors = [
    (AppColors.primary, Colors.white),
    (AppColors.darkGray, Colors.white),
    (Colors.white, AppColors.darkGray),
  ];

  (Color, Color) _colorsFor(int index) =>
      _innoColors[index % _innoColors.length];

  @override
  Widget build(BuildContext context) => MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        physics: const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16).copyWith(
          bottom: RootPage.navigationBarHeight + 16,
        ),
        itemCount: widget.events.length,
        itemBuilder: (context, i) {
          final colors = _colorsFor(i);
          return EventCard(
            cardColor: colors.$1,
            textColor: colors.$2,
            event: widget.events.get(i),
          );
        },
      );
}
