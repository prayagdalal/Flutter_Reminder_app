// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:reminder_app/presentation/Home/home.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
//      onSelectNotification: selectNotification,
    );
  }

  Future<void> repeatNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'main_channel', 'Main Channel', 'Main channel notifications',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            showProgress: true,
            enableVibration: true,
            ledColor: green,
            icon: 'app_icon');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(1, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    print('in APIS');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      //_nextInstanceOfTenAM(),
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel', 'Main Channel', 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            enableVibration: true,
            icon: 'app_icon'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  // tz.TZDateTime _nextInstanceOfTenAM() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledDate =
  //       tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));
  //   // tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
  //   if (scheduledDate.isAfter(now)) {
  //     scheduledDate = scheduledDate.add(const Duration(seconds: 5));
  //   }
  //   return scheduledDate;
  // }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelNotification(int task_id) async {
    await flutterLocalNotificationsPlugin.cancel(task_id);
  }

  Future<dynamic> selectNotification(String? payload) async {
    if (payload != null) {
      print(payload);
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => Home());
  }
}
