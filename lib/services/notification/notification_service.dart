import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';

import 'domain/model/custom_notification.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  Future<void> _setupNotifications() async {
    await _setUpTimeZone();
    await _initializeNotifications();
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );
  }

  showNotification(CustomNotification notification) {
    androidDetails = const AndroidNotificationDetails(
      'lembrete_notifications',
      'Lembretes',
      channelDescription: 'Notificações de lembretes',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );
    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  showNotificationSchedule(CustomNotification notification) {
    final date = DateTime.now().add(const Duration(seconds: 5));
    androidDetails = const AndroidNotificationDetails(
      'lembrete_notifications',
      'Lembretes',
      channelDescription: 'Notificações de lembretes',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );
    localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(date, tz.getLocation('America/Sao_Paulo')),
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      // print('Launched by notification');
    }
  }

  Future<void> _setUpTimeZone() async {
    initializeTimeZones();
    var easternTimeZone = tz.getLocation('America/Sao_Paulo');
    tz.setLocalLocation(easternTimeZone);
  }
}
