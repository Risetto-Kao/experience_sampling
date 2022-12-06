import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/models/week_time.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/reuse_util/new_notification.dart';
import 'package:experience_sampling/presentation/reuse_util/util.dart';
import 'package:experience_sampling/presentation/router/route_config.dart';

class NotificationAPIController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void sendNotification() {
    NotificationApi.showNotification(id: 788);
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
    LocalStorage().writeLog(
        "${LogTag.notification}, ${LogSubTag.listen}, listenNotifications");
  }

  //! TO ADD:
  void onClickedNotification(String? payload) {
    if (payload == "end") {
      LocalStorage().writeLog(
          "${LogTag.notification}, ${LogSubTag.listen}, onClickedEndNotification");
      Get.toNamed(RouteConfig.homepage);
    } else {
      LocalStorage().writeLog(
          "${LogTag.notification}, ${LogSubTag.listen}, onClickedNotification");
      Get.toNamed(RouteConfig.questionnaire);
    }
  }

  Future<void> sendNext12Notifications(int notificationID) async {
    if (notificationID < -1) return;
    LocalStorage localStorage = LocalStorage(destination: "time_list");
    List<DateTime> timeList = await localStorage.readWeekTime();
    for (int i = notificationID + 1; i < notificationID + 13; i++) {
      if (i >= 56) break;
      NotificationApi.weeklyNotification(
          id: i, time: timeList[i], canSound: true);
      for (int j = 100; j <= 400; j += 100) {
        NotificationApi.remindNotification(
            id: j + i, time: timeList[i], canSound: true);
      }
    }
    NotificationApi.researchFinishedNotification();
  }

  Future<void> generateWeeklyTime() async {
    final config = DefaultConfig.getInstance();
    int hour = config.settingHour;
    int minute = config.settingMinute;
    Time startedTime = Time(hour, minute, 0);
    var timeList = generateList(startedTime);
    LocalStorage localStorage = LocalStorage(destination: "time_list");

    String timeListString = "";

    for (int i = 0; i < timeList.length; i++) {
      var time = timeList[i];
      if (i == timeList.length - 1)
        timeListString += time.toString();
      else
        timeListString += time.toString() + "\n";
    }
    await localStorage.writeFile(timeListString);
  }

  List<DateTime> generateList(Time startedTime) {
    int startID = 0;
    var dateTimeList = <DateTime>[];
    DateTime now = DateTime.now();

    for (int weekday = 0; weekday < 7; weekday++) {
      for (int count = 1; count <= 8; count++) {
        Time time = _generateRandomTime(count, startedTime);
        DateTime dateTime = DateTime(now.year, now.month, now.day, time.hour,
                time.minute, time.second)
            .add(Duration(days: weekday));
        dateTimeList.add(dateTime);
      }
    }
    print(now.toString());
    print('-----' * 3);
    for (int i = 0; i < dateTimeList.length; i++) {
      DateTime tmp = dateTimeList[i];
      if (now.isAfter(tmp)) {
        dateTimeList[i] = tmp.add(Duration(days: 7));
      }
    }
    dateTimeList.sort((a, b) => a.compareTo(b));

    return dateTimeList;
  }

  Time _generateRandomTime(int index, Time time) {
    if (index <= 0 || index >= 9) {
      print("index is not valid: $index");
      throw Error();
    }

    final int startTime = time.hour * 60 + time.minute;
    final int block = 90;
    final int half = 15;
    int floor = startTime + (index - 1) * block + half;
    int ceiling = startTime + index * block - half;
    int randomTime = Random().nextInt(ceiling - floor) + floor;
    int setHour = (randomTime / 60).floor();
    int setMinute = randomTime % 60;

    if (setHour >= 24) setHour -= 24;

    return Time(setHour, setMinute, 0);
  }

  void cancelAllNotification() {
    NotificationApi.cancelAll();
  }

  void cancelNotification(int id) {
    NotificationApi.cancel(id);
  }
}
