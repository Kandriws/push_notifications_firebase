part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChange extends NotificationsEvent {
  final AuthorizationStatus status;

  const NotificationStatusChange(this.status);
}

class NotificationPushMessageReceived extends NotificationsEvent {
  final List<PushMessage> notifications;

  const NotificationPushMessageReceived(this.notifications);
}

class NotificationRemoveMessage extends NotificationsEvent {
  final String messageId;

  const NotificationRemoveMessage(this.messageId);
}
