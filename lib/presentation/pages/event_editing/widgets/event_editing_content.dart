import 'package:flutter/material.dart';
import 'editing_cost.dart';
import 'editing_cover.dart';
import 'editing_date.dart';
import 'editing_desc.dart';
import 'editing_location.dart';
import 'editing_switch.dart';
import 'editing_title.dart';

class EventEditingContent extends StatelessWidget {
  const EventEditingContent({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EditingCover(),
          const SizedBox(height: 40),
          ...[
            const EditingTitle(),
            const EditingDesc(),
            const EditingSwitch(),
            const EditingLocation(),
            const EditingCost(),
            const EditingDate(),
          ].map(
            (w) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: w,
            ),
          ),
        ],
      );
}
