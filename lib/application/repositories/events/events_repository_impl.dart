import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../data/events/events_gateway.dart';
import '../../mappers/event_mapper.dart';
import '../../models/cost.dart';
import '../../models/event.dart';
import 'events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl(this._uuid, this._gateway);

  final Uuid _uuid;
  final EventsGateway _gateway;

  // late final _random = Random();

  Map<String, EventModel>? _cache;
  _ModifiedEvent? _modifiedEvent;

  // DateTime get _radomDateTime => DateTime(
  //       2025,
  //       _random.nextInt(7) + 5,
  //       _random.nextInt(28),
  //       _random.nextInt(12) + 9,
  //       _random.nextInt(2) * 30,
  //     );

  // static const _descs = [
  //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla ligula erat, vitae accumsan nisi accumsan in. Suspendisse blandit leo quis diam posuere, placerat posuere nisi aliquet.',
  //   'This layout facilitates the browsing of uncropped peer content. Container heights are sized based on the widget size.',
  //   'Evenly divided in n columns',
  //   'Core subdomain - describes the main value the software brings. Supporting subdomain - describes what the software has to do to work correctly. Generic subdomain - describes what can be outsourced'
  // ];

  // static const _titles = [
  //   'Skydiving in Dubai',
  //   'Step 2: Establish a common dictionary',
  //   'Convert the data source into a list of widgets',
  //   'Event 23'
  // ];

  // String get _randomDesc => _descs[_random.nextInt(_descs.length)];

  // String get _randomTitle => _titles[_random.nextInt(_titles.length)];

  @override
  Future<Iterable<EventModel>> getEvents() async {
    await _loadEvents();
    return _cache!.values;
  }

  Future<void> _loadEvents({bool refresh = false}) async {
    if (!refresh && _cache != null) {
      return;
    }
    final data = await _gateway.loadEvents();
    final eventModels = data.map(EventMapper.eventFromData);
    // Iterable.generate(
    //   5,
    //   (_) => EventModel(
    //     eventId: _uuid.v4(),
    //     title: _randomTitle,
    //     description: _randomDesc,
    //     location: 'UAE, Dubai',
    //     occurringAt: _radomDateTime,
    //     cost: const CostModel(number: 12, currency: Currency.aed),
    //     coverUrl: null,
    //     onlineEvent: false,
    //   ),
    // );
    // Fill the cache
    _cache?.clear();
    _cache ??= {};
    for (final e in eventModels) {
      _cache![e.eventId] = e;
    }
  }

  @override
  EventModel createEvent() {
    final event = EventModel(
      eventId: _uuid.v4(),
      title: 'Untitled',
      description: '',
      coverUrl: null,
      location: 'Innopolis',
      cost: const CostModel(number: 0, currency: Currency.rub),
      occurringAt: DateTime.now(),
      onlineEvent: false,
    );
    _addToCache(event);
    _modifiedEvent = _ModifiedEvent(event.eventId, true);
    return event;
  }

  Future<void> _addToCache(EventModel model) async {
    await _loadEvents();
    _cache![model.eventId] = model;
  }

  @override
  Future<void> modifyEvent(EventModel event) => _addToCache(event);

  @override
  Future<void> save() async {
    if (_cache == null) {
      // Events have to be loaded at least, otherwise there is nothing to save
      return;
    }
    final event = _modifiedEvent;
    if (event == null) {
      // Nothing modified, so nothing to save
      return;
    }
    final eventModel = _cache![event.eventId];
    if (eventModel == null) {
      // Event not found in the cache
      return;
    }
    final eventRequest = EventMapper.eventRequestFromModel(eventModel);
    if (event.isNewlyCreated) {
      await _gateway.addEvent(event.eventId, eventRequest);
    }
    _modifiedEvent = null;
  }

  @override
  Future<Option<EventModel>> getOneEvent(String eventId) async {
    await _loadEvents();
    return Option.fromNullable(_cache![eventId]);
  }
}

class _ModifiedEvent {
  _ModifiedEvent(this.eventId, this.isNewlyCreated);
  final String eventId;
  final bool isNewlyCreated;
}
