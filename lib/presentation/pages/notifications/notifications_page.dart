import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/notifications/notifications_cubit.dart';
import '../../blocs/notifications/notifications_state.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_scaffold.dart';
import 'widgets/notification_tile.dart';

@RoutePage()
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    context.read<NotificationsCubit>().loadNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Notifications',
    body: AppChildBody(
      padding: EdgeInsets.zero,
      child: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) => switch (state.list) {
          LoadedStateData(:final data) when data.isEmpty => Center(
            child: Text('No notifications', style: AppTextStyles.caption),
          ),
          LoadedStateData(:final data) => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, i) =>
                NotificationTile(notification: data[i]),
          ),
          LoadedStateError(:final error) => Center(
            child: Text(error, style: AppTextStyles.caption),
          ),
          _ => const Center(child: AppLoader(inCard: true)),
        },
      ),
    ),
  );
}
