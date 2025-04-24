import 'package:flutter_bloc/flutter_bloc.dart';

class EventParticipateCubit extends Cubit<bool> {
  EventParticipateCubit() : super(false);

  void showLoading() {
    emit(true);
  }

  void finishedLoading() {
    emit(false);
  }
}