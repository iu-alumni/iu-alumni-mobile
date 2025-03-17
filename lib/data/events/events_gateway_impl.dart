import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/cost.dart';
import '../models/event_data_model.dart';
import '../models/event_request_data_model.dart';
import '../paths.dart';
import 'events_gateway.dart';

class EventsGatewayImpl implements EventsGateway {
  EventsGatewayImpl(this._dio);

  final Dio _dio;

  late final _random = Random();

  DateTime get _randomDateTime => DateTime(
        2025,
        _random.nextInt(7) + 5,
        _random.nextInt(28),
        _random.nextInt(12) + 9,
        _random.nextInt(2) * 30,
      );

  static const _descs = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla ligula erat, vitae accumsan nisi accumsan in. Suspendisse blandit leo quis diam posuere, placerat posuere nisi aliquet.',
    'Sed augue quam, tincidunt et molestie quis, mollis vel nulla. Proin nec neque ut tellus tincidunt sollicitudin non tincidunt nibh. Etiam pellentesque nisl quis diam rutrum semper. Donec eget lacinia dui, a tempor velit. Suspendisse tincidunt massa nec purus dignissim laoreet. Vestibulum volutpat faucibus sapien, in tempor libero hendrerit non.',
    'Aenean viverra risus in massa finibus, et dignissim ipsum consequat.',
  ];

  static const _titles = [
    'Skydiving in Dubai',
    'Museum in Berlin',
    'Valeriy Meladze\'s Best Songs Concert in Moscow',
    'Stand Up Comedy show in Istanbul'
  ];

  String get _randomDesc => _descs[_random.nextInt(_descs.length)];

  String get _randomTitle => _titles[_random.nextInt(_titles.length)];

  EventDataModel get _randomEvent => EventDataModel(
        eventId: '${_random.nextInt(1000)}',
        ownerId: '${_random.nextInt(1000)}',
        participantsIds: [],
        title: _randomTitle,
        description: _randomDesc,
        location: 'Russia, Innopolis',
        datetime: _randomDateTime,
        cost: _random.nextInt(100).toDouble(),
        isOnline: false,
        cover: '',
      );

  @override
  Future<void> addEvent(EventRequestDataModel event) =>
      TaskOption.tryCatch(() async {
        // final data = jsonEncode(event);
        // await _dio.post(Paths.events, data: data);
      })
          .run();

  @override
  Future<Iterable<EventDataModel>> loadEvents() =>
      TaskOption.tryCatch(() async {
        return Iterable.generate(5, (_) => _randomEvent);
        // TODO uncomment when the back-end is ready
        // final resp = await _dio.get(Paths.events);
        // final list = jsonDecode(resp.data) as List;
        // return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
      }).match<Iterable<EventDataModel>>(() => [], identity).run();
}
