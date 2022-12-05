import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:experience_sampling/data/models/week_time.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, "id: $id", body, _notificationDetails(),
          payload: payload);

  static _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails('remind_channel', '提醒通知',
          enableVibration: true,
          vibrationPattern:
              Int64List.fromList(<int>[1000, 1000, 1000, 1000, 1000]),
          importance: Importance.max,
          priority: Priority.max,
          enableLights: true,
          visibility: NotificationVisibility.public,
          playSound: true),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      settings,
    );

    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.notificationResponse?.payload);
    }

    if (initScheduled) {
      tz.initializeTimeZones();
      final localName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localName));
    }
  }

  static Future weeklyNotification(
      {required int id,
      String? payload,
      required DateTime time,
      required bool canSound}) async {
    print(
        "notificationID: $id sent at weekday:${time.weekday}, ${time.hour}:${time.minute}");
    LocalStorage().writeFile(
        "${LogTag.notification}, notificationID: $id sent at weekday:${time.weekday}, ${time.hour}:${time.minute}");
    return _notifications.zonedSchedule(
        id,
        "重要通知",
        "填問卷時間到！請於五分鐘內開始填寫問卷",
        tz.TZDateTime.from(time, tz.getLocation('Asia/Taipei')),
        _notificationDetails(),
        payload: id.toString(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  static Future remindNotification(
      {required int id,
      String? payload,
      required DateTime time,
      required bool canSound}) async {
    double dtype = id / 100;
    int type = dtype.floor();
    String title = "通知提醒";
    String content = "請盡快開始填寫問卷！";

    DateTime newTime;
    if (type == 4) {
      content = "本次問卷超時，下次請記得填寫";
      newTime = time.add(Duration(seconds: 300));
    } else {
      content = "請盡快開始填寫問卷！";
      newTime = time.add(Duration(seconds: type * 90));
    }

    print(
        "notificationID: $id sent at weekday:${newTime.weekday}, ${newTime.hour}:${newTime.minute}");
    LocalStorage().writeFile(
        "${LogTag.notification}, notificationID: $id sent at weekday:${newTime.weekday}, ${newTime.hour}:${newTime.minute}");
    return _notifications.zonedSchedule(
        id,
        title,
        content,
        tz.TZDateTime.from(newTime, tz.getLocation('Asia/Taipei')),
        _notificationDetails(),
        payload: id.toString(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  static Future researchFinishedNotification() async {
    String title = "研究結束";
    String body = "本研究到此結束，請至「首頁」查看注意事項";
    LocalStorage localStorage = LocalStorage(destination: "time_list");
    DateTime lastTime = await localStorage.readLastTime();
    DateTime deadline = lastTime.add(Duration(minutes: 30));

    print(
        "researchFinishedNotification sent at weekday:${deadline.month}/${deadline.day}, ${deadline.weekday} , ${deadline.hour}:${deadline.minute}");
    LocalStorage().writeFile(
        "${LogTag.notification}, researchFinishedNotification sent at weekday:${deadline.weekday}, ${deadline.hour}:${deadline.minute}");

    return _notifications.zonedSchedule(
        500,
        title,
        body,
        tz.TZDateTime.from(deadline, tz.getLocation('Asia/Taipei')),
        _notificationDetails(),
        payload: "end",
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  static tz.TZDateTime _scheduledDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduledTime.isBefore(now)
        ? scheduledTime.add(Duration(days: 1))
        : scheduledTime;
  }

  static tz.TZDateTime _scheduledWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduledDaily(time);
    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }

  static void cancel(int id) {
    _notifications.cancel(id);
    print("cancel notification: $id");
  }

  static void cancelAll() {
    _notifications.cancelAll();
    print("cancel all notificaitons");
  }

  static void cancelRemind(int id) {
    int nid = id % 100;
    _notifications.cancel(nid);
    _notifications.cancel(nid + 100);
    _notifications.cancel(nid + 200);
    _notifications.cancel(nid + 300);
    _notifications.cancel(nid + 400);
  }
}
