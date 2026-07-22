import 'package:dio/dio.dart';

import '../../application/models/paginated_result.dart';
import '../common/dio_options_manager.dart';
import '../models/notification_data_model.dart';
import '../paths.dart';
import 'notifications_gateway.dart';

class NotificationsGatewayImpl implements NotificationsGateway {
  NotificationsGatewayImpl(this._dio, this._optionsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;

  @override
  Future<PaginatedResult<NotificationDataModel>> loadNotifications({
    String? cursor,
    int limit = 50,
  }) async {
    try {
      final resp = await _dio.get(
        Paths.notifications,
        options: _optionsManager.opts(),
        queryParameters: {
          if (cursor != null) 'cursor': cursor,
          'limit': limit,
        },
      );
      final data = resp.data;
      if (data is! Map<String, dynamic> || data['items'] is! List) {
        return const PaginatedResult(items: []);
      }
      return PaginatedResult.fromJson(
        data,
        (e) => NotificationDataModel.fromJson(e as Map<String, dynamic>),
      );
    } catch (_) {
      return const PaginatedResult(items: []);
    }
  }

  @override
  Future<int> loadUnreadCount() async {
    try {
      final resp = await _dio.get(
        Paths.notificationsUnreadCount,
        options: _optionsManager.opts(),
      );
      final data = resp.data as Map<String, dynamic>;
      return data['count'] as int? ?? 0;
    } catch (_) {
      return 0;
    }
  }
}
