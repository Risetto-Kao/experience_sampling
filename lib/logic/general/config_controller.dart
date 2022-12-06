import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/models/once_config.dart';
import 'package:experience_sampling/data/models/week_time.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/general/new_notification_controller.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';

class ConfigController extends GetxController {
  // Once Config
  var isValidTime = false.obs;
  var status = ExpStatus.NOT_STARTED.obs;
  var notificationID = 0.obs;

  // Default Config
  var subjectID = "S000".obs;
  var password = "".obs;
  var settingHour = 0.obs;
  var settingMinute = 0.obs;
  var isSettingCompleted = false.obs;
  var isMute = false.obs;

  var notificationController = Get.find<NotificationAPIController>();

  @override
  void onInit() {
    initOnceConfig();
    super.onInit();
  }

  Future<void> initOnceConfig() async {
    DateTime now = DateTime.now();
    await initDefaultConfig();

    if (isSettingCompleted.value) status.value = ExpStatus.RUNNING;

    LocalStorage localStorage = LocalStorage(destination: 'time_list');
    DateTime weekTime = await localStorage.readLastTime();
    DateTime deadline = weekTime.add(Duration(minutes: 5));

    if (now.isAfter(deadline)) status.value = ExpStatus.END;

    await isNowValid();

    OnceConfig.getInstance()
        .update(status.value, notificationID.value, isValidTime.value);
    print(DefaultConfig.getInstance().toString());
    print(OnceConfig.getInstance().toString());
  }

  void startExp() async {
    status.value = ExpStatus.RUNNING;
    SharedPreferences.getInstance().then((value) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      String startExpDate = dateFormat.format(DateTime.now());
      value.setString('startExpDate', startExpDate);
    });
    await notificationController.generateWeeklyTime();
    notificationController.sendNext12Notifications(-1);
  }

  void endExp() {
    status.value = ExpStatus.END;
  }

  String get getCache {
    String pre = subjectID.value;
    String post = password.value;
    var tmp = utf8.encode(pre + post); // data being hashed
    var res = sha256.convert(tmp).toString().toUpperCase(); // Hashing Process
    return res;
  }

  Future<void> initDefaultConfig() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    settingHour.value = sharedPreferences.getInt("settingHour") ?? 0;
    settingMinute.value = sharedPreferences.getInt("settingMinute") ?? 0;
    subjectID.value = sharedPreferences.getString("subjectID") ?? "S000";
    password.value = sharedPreferences.getString("password") ?? "";
    isSettingCompleted.value =
        sharedPreferences.getBool("isSettingCompleted") ?? false;
    isMute.value = sharedPreferences.getBool("isMute") ?? false;

    DefaultConfig.getInstance().update(subjectID.value, password.value,
        settingHour.value, settingMinute.value, isSettingCompleted.value);
    LocalStorage().writeLog(
        "${LogTag.config}, ${LogSubTag.done}, initDefaultConfig: isSettingCompleted, ${isSettingCompleted.value}");
  }

  String get cache {
    var tmp =
        utf8.encode(subjectID.value + password.value); // data being hashed
    var res = sha256.convert(tmp).toString().toUpperCase(); // Hashing Process
    return res;
  }

  Future<void> saveDefaultConfig() async {
    if (!hasBeenComplete()) return;
    isSettingCompleted.value = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("subjectID", subjectID.value);
    sharedPreferences.setString("password", password.value);
    sharedPreferences.setInt("settingHour", settingHour.value);
    sharedPreferences.setInt("settingMinute", settingMinute.value);
    sharedPreferences.setBool("isSettingCompleted", isSettingCompleted.value);
    sharedPreferences.setBool("isMute", isMute.value);
    DefaultConfig.getInstance().update(subjectID.value, password.value,
        settingHour.value, settingMinute.value, isSettingCompleted.value);
    LocalStorage()
        .writeLog("${LogTag.config}, ${LogSubTag.done}, saveDefaultConfig");
  }

  bool hasBeenComplete() {
    if (subjectID == "S000") return false;
    if (settingHour == 0 && settingMinute == 0) return false;
    return true;
  }

  Future<void> isNowValid() async {
    LocalStorage localStorage = LocalStorage(destination: "time_list");
    List<DateTime> timeList = await localStorage.readWeekTime();
    if (timeList.length == 0) return;
    DateTime now = DateTime.now();
    for (var i = 0; i < 56; i++) {
      DateTime startTime = timeList[i];
      DateTime endTime = startTime.add(Duration(minutes: 5));

      if (now.isAfter(startTime) && now.isBefore(endTime)) {
        isValidTime.value = true;
        notificationID.value = i;
        return;
      }
    }
  }
}
