import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context
            .select((NotificationsBloc bloc) => Text('${bloc.state.status}')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
          ),
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Dismissible(
          key: Key(notification.messageId),
          onDismissed: (direction) {
            context
                .read<NotificationsBloc>()
                .add(NotificationRemoveMessage(notification.messageId));
          },
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red.shade400,
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: ListTile(
            leading: notification.imageUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(notification.imageUrl!),
                  )
                : const CircleAvatar(
                    child: Icon(Icons.notification_important),
                  ),
            title: Text(notification.title),
            subtitle: Text(notification.body),
            trailing: Text(notification.sentDateTime.toString()),
            onTap: () {
              context.push('/details/${notification.messageId}');
            },
          ),
        );
      },
    );
  }
}
