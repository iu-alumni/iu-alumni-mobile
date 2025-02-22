import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/event.dart';
import 'events_list_state.dart';

class EventsListCubit extends Cubit<EventsListState> {
  EventsListCubit() : super(const EventsListState.none());

  late final _random = Random();

  DateTime get _radomDateTime => DateTime(
        2025,
        _random.nextInt(7) + 5,
        _random.nextInt(28),
        _random.nextInt(12) + 9,
        _random.nextInt(2) * 30,
      );

  static const _descs = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla ligula erat, vitae accumsan nisi accumsan in. Suspendisse blandit leo quis diam posuere, placerat posuere nisi aliquet.',
    'This layout facilitates the browsing of uncropped peer content. Container heights are sized based on the widget size.',
    'Evenly divided in n columns',
    'Core subdomain - describes the main value the software brings. Supporting subdomain - describes what the software has to do to work correctly. Generic subdomain - describes what can be outsourced'
  ];

  static const _titles = [
    'Skydiving in Dubai',
    'Step 2: Establish a common dictionary',
    'Convert the data source into a list of widgets',
    'Event 23'
  ];

  String get _randomDesc => _descs[_random.nextInt(_descs.length)];

  String get _randomTitle => _titles[_random.nextInt(_titles.length)];

  Future<void> loadEvents() async {
    // TODO loading
    final events = await Future.delayed(
      const Duration(seconds: 1),
      () => IList(
        Iterable.generate(
          20,
          (_) => EventModel(
            title: _randomTitle,
            description: _randomDesc,
            location: 'UAE, Dubai',
            occurringAt: _radomDateTime,
          ),
        ),
      ),
    );
    emit(EventsListState.data(events: events));
  }
}
