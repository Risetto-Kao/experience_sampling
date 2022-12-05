// import 'dart:io' show Platform;
// import 'package:rxdart/subjects.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:test_app/presentation/reuse_util/functions.dart';

// class ReceiveNotification {
//   final int id;
//   final String title;
//   final String body;
//   final String payload;
//   ReceiveNotification(
//       {required this.id,
//       required this.title,
//       required this.body,
//       required this.payload});
// }

// class LocalNotificationManager {
//   var initSetting;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
//       BehaviorSubject<ReceiveNotification>();

//   LocalNotificationManager.init() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     if (Platform.isIOS) requestIOSPermission();
//     initializePlatform();
//     // tmp().then((value) => null);
//   }

//   requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()!
//         .requestPermissions(alert: true, badge: true, sound: true);
//   }

//   initializePlatform() {
//     var initSettingAndroid =
//         AndroidInitializationSettings('app_notification_icon');
//     var initSettingIOS = IOSInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification: (id, title, body, payload) async {
//           ReceiveNotification notification = ReceiveNotification(
//               id: id, title: title!, body: body!, payload: payload!);
//           didReceiveLocalNotificationSubject.add(notification);
//         });
//     initSetting = InitializationSettings(
//         android: initSettingAndroid, iOS: initSettingIOS);
//   }

//   setOnNotificationReceive(Function notificationReceive) {
//     printInBlue('setOnNotificationReceive');

//     didReceiveLocalNotificationSubject.listen((notification) {
//       notificationReceive(notification);
//     });
//   }

//   setOnNotificationClick(Function notificationClick) async {
//     printInBlue('setOnNotificationClick');
//     await flutterLocalNotificationsPlugin.initialize(initSetting,
//         onSelectNotification: (String? payload) async {
//       await notificationClick(payload);
//       // 每個都先送然後如果有按通知再取消
//       // 中間的間隔也可以這樣做

//       // flutterLocalNotificationsPlugin.cancel(1);
//     });
//   }

//   Future<void> scheduleNotification(
//       {required int channelID,
//       required int delayFrequency,
//       required int delaySeconds}) async {
//     var scheduleNotificationDateTime =
//         DateTime.now().add(Duration(seconds: delayFrequency * delaySeconds));
//     var androidChannel = AndroidNotificationDetails(
//       channelID.toString(),
//       'test_channel',
//       'CHANNEL_DESCRIPTION',
//       importance: Importance.max,
//       priority: Priority.max,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//       timeoutAfter: 1000 * 5,
//       enableLights: true,
//     );

//     var iosChannel = IOSNotificationDetails(sound: 'notification_sound');
//     var platformChannel =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);
//     await flutterLocalNotificationsPlugin.schedule(
//         channelID,
//         '填寫問卷提醒',
//         '記得填問卷 快沒時間了 notificationID: $channelID',
//         scheduleNotificationDateTime,
//         platformChannel,
//         payload: channelID.toString());
//   }

//   Future<void> showNotification(int channelID) async {
//     var androidChannel = AndroidNotificationDetails(
//       '$channelID',
//       'now for test',
//       'CHANNEL_DESCRIPTION',
//       importance: Importance.max,
//       priority: Priority.max,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//       timeoutAfter: 1000 * 5 * 60,
//       enableLights: true,
//     );

//     var iosChannel = IOSNotificationDetails(sound: 'notification_sound');
//     var platformChannel =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);

//     await flutterLocalNotificationsPlugin.show(
//         channelID, '測試', '測試用的通知', platformChannel,
//         payload: 'channel ID is: $channelID');
//   }

//   Future<void> showWeeklyAtDayTime(
//       int channelID, Day day, int hour, int minute, int second) async {
//     // var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
//     var androidChannel = AndroidNotificationDetails(
//       channelID.toString(),
//       'CHANNEL_NO$channelID',
//       'CHANNEL_DESCRIPTION 5',
//       importance: Importance.max,
//       priority: Priority.max,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//       timeoutAfter: 1000 * 60 * 5,
//       enableLights: true,
//     );

//     var iosChannel = IOSNotificationDetails(sound: 'notification_sound');
//     var platformChannel =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);
//     await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//         channelID,
//         '填寫問卷提醒',
//         '已經到了填答問卷的時間囉！請點擊此處開始填寫問卷，此通知將於${DateTime.now().add(Duration(minutes: 5))}時關閉',
//         day,
//         Time(hour, minute, second),
//         platformChannel,
//         payload: '$channelID');
//     print(' Notification: No. $channelID, at ${day.toString()}, $hour, $minute, $second is pushed');
//   }

//   void cancelNotification(int channelID) =>
//       flutterLocalNotificationsPlugin.cancel(channelID);

//   void cancelAllNotification() => flutterLocalNotificationsPlugin.cancelAll();
// }
