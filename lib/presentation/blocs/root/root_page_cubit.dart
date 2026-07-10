import 'package:flutter_bloc/flutter_bloc.dart';

enum RootPageState { eventsListPage, mapPage, projectsListPage, profilePage }

class RootPageCubit extends Cubit<RootPageState> {
  RootPageCubit() : super(RootPageState.eventsListPage);

  void navigateTo(RootPageState page) => emit(page);
}
