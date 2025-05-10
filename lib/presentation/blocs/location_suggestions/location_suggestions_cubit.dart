import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

import '../../../application/repositories/map/map_repository.dart';
import '../../common/models/loaded_state.dart';

typedef LocationSuggestionsState = LoadedState<List<String>>;

class LocationSuggestionsCubit extends Cubit<LocationSuggestionsState> {
  LocationSuggestionsCubit(this._mapRepository)
      : super(const LoadedState.init());

  final MapRepository _mapRepository;

  static const _debouncePeriod = Duration(milliseconds: 500);

  late final _debouncer = Debouncer();

  void suggest(String city) {
    if (city.isEmpty) {
      return;
    }
    _debouncer.debounce(
      duration: _debouncePeriod,
      onDebounce: _loadSuggestions(city),
    );
  }

  void Function() _loadSuggestions(String city) => () async {
        emit(const LoadedState.loading());
        final sugs = await _mapRepository.suggestions(city);
        final list = [for (final s in sugs) '${s.country}, ${s.city}'];
        emit(LoadedState.data(list));
      };
}
