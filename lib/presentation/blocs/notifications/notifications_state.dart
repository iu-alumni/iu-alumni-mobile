import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../application/models/notification.dart';
import '../../common/models/loaded_state.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(0) int unreadCount,
    @Default(LoadedState.init()) LoadedState<List<NotificationModel>> list,
  }) = _NotificationsState;
}
