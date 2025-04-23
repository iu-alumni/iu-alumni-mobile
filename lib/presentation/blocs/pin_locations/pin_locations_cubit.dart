import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/map/map_repository.dart';
import '../../common/models/loaded_state.dart';

typedef PinLocationsState = LoadedState<MapInfo>;

class PinLocationsCubit extends Cubit<PinLocationsState> {
  PinLocationsCubit(this._mapRepository) : super(const LoadedState.init());

  final MapRepository _mapRepository;

  void update() async {
    if (state is! LoadedStateInit) {
      return;
    }
    final mapInfo = await _mapRepository.getUsersOnMap();
    emit(LoadedState.data(mapInfo));
  }
}
