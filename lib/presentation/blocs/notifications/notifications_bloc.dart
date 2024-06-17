import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;

  final Future<void> Function()? requestLocalNotificationPermission;
  final void Function({
    required int id,
    String? title,
    String? body,
    String? data,
  })? showLocalNotification;

  NotificationsBloc(
      {this.requestLocalNotificationPermission, this.showLocalNotification})
      : super(const NotificationsState()) {
    on<NotificationStatusChange>(_notificationStatusChange);
    on<NotificationPushMessageReceived>(_notificationPushMessage);
    on<NotificationRemoveMessage>(_notificationRemoveMessage);

    _checkingPermission();
    _onForegroundMessage();
  }

  static Future<void> initializedFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChange(
      NotificationStatusChange event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _notificationPushMessage(
      NotificationPushMessageReceived event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(notifications: event.notifications));
  }

  void _notificationRemoveMessage(
      NotificationRemoveMessage event, Emitter<NotificationsState> emit) {
    final notifications = state.notifications
        .where((element) => element.messageId != event.messageId)
        .toList();
    emit(state.copyWith(notifications: notifications));
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    final notification = PushMessage(
      messageId: message.messageId?.replaceAll(RegExp(r'[^\w]'), '') ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDateTime: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );

    if (showLocalNotification != null) {
      showLocalNotification!(
        id: ++pushNumberId,
        title: notification.title,
        body: notification.body,
        data: notification.messageId,
      );
    }

    add(NotificationPushMessageReceived(
        [...state.notifications, notification]));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (requestLocalNotificationPermission != null) {
      await requestLocalNotificationPermission!();
    }

    add(NotificationStatusChange(settings.authorizationStatus));
  }

  void _checkingPermission() async {
    final NotificationSettings settings =
        await messaging.getNotificationSettings();
    add(NotificationStatusChange(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print('Token: $token');
  }

  PushMessage? getNotificationById(String messageId) {
    final exist =
        state.notifications.any((element) => element.messageId == messageId);
    if (!exist) return null;
    return state.notifications
        .firstWhere((element) => element.messageId == messageId);
  }
}
