import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/cost.dart';
import '../../../application/models/event.dart';

typedef OneEventState = Option<EventModel>;

class OneEventCubit extends Cubit<OneEventState> {
  OneEventCubit() : super(const None());

  late final _random = Random();

  void setEvent(String uid) {
    // TODO repository call
    emit(
      Option.of(
        EventModel(
          eventId: '${_random.nextInt(1000000)}',
          title: 'Skydiving in Dubai',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla ligula erat, vitae accumsan nisi accumsan in. Suspendisse blandit leo quis diam posuere, placerat posuere nisi aliquet.',
          location: 'UAE, Dubai',
          occurringAt: DateTime(
            2025,
            _random.nextInt(7) + 5,
            _random.nextInt(28),
            _random.nextInt(12) + 9,
            _random.nextInt(2) * 30,
          ),
          cost: const CostModel(number: 12, currency: Currency.aed),
          coverUrl: null
        ),
      ),
    );
  }
}
