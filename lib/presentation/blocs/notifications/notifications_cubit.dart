import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/notifications/notifications_repository.dart';
import '../../common/models/loaded_state.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsState());

  final NotificationsRepository _repository;

  /// The panel shows at least the last few read notifications alongside
  /// the unread ones — read ones just render lighter. This is a floor on
  /// how many *read* notifications pad out the list, not a hard cap: every
  /// unread notification is always shown, however many there are.
  static const _minDisplayed = 10;

  /// Cheap poll for the bell badge — does not mark anything as read.
  Future<void> loadUnreadCount() async {
    final count = await _repository.getUnreadCount();
    emit(state.copyWith(unreadCount: count));
  }

  /// Loads the list (soonest-first). Per the backend, this marks every
  /// currently unread notification as read, so the badge is cleared
  /// locally too — they won't show as "new" again on a later session,
  /// though they stay visible in the panel (just lighter).
  Future<void> loadNotifications() async {
    emit(state.copyWith(list: const LoadedState.loading()));
    final notifications = await _repository.getNotifications();

    final unread = notifications.where((n) => !n.read);
    final read = notifications.where((n) => n.read);
    final readSlots = _minDisplayed - unread.length;
    final displayed = [
      ...unread,
      ...read.take(readSlots > 0 ? readSlots : 0),
    ];

    emit(
      state.copyWith(
        list: LoadedState.data(displayed),
        unreadCount: 0,
      ),
    );
  }
}
