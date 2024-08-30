import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:travelplannerapp/main.dart';
import 'package:travelplannerapp/services/notification/notification_service.dart';
import 'package:travelplannerapp/src/features/travel/presenter/widgets/confirm_presence_bottom_sheet_widget.dart';

import 'domain/model/custom_notification.dart';

class FirebaseMessagingService {
  FirebaseMessagingService(this._notificationService);

  final NotificationService _notificationService;

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  void getDeviceFirebaseToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  void _onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showModalBottomSheet(
          context: NavigatorService.navigatorKey.currentContext!,
          builder: (context) => ConfirmPresenceBottomSheetWidget(
            map: message.data,
          ),
        );

        _notificationService.showNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title,
            body: notification.body,
            payload: message.data['payload'] ?? '',
          ),
        );
      }
    });
  }

  void _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _notificationService.showNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title,
            body: notification.body,
            payload: message.data['payload'] ?? '',
          ),
        );
      }
    });
  }
}
