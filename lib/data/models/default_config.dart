import 'dart:convert';

import 'package:crypto/crypto.dart';

class DefaultConfig {
  DefaultConfig._({
    this.subjectID = "S000",
    this.password = "",
    this.settingHour = 0,
    this.settingMinute = 0,
    this.isSettingComplete = false,
  });

  String subjectID;
  int settingHour;
  int settingMinute;
  bool isSettingComplete;
  String password;

  static DefaultConfig _instance = DefaultConfig._();
  factory DefaultConfig.getInstance() {
    return DefaultConfig._instance;
  }

  void update(
      String sid, String password, int sHour, int sMinute, bool complete) {
    this.subjectID = sid;
    this.password = password;
    settingHour = sHour;
    settingMinute = sMinute;
    isSettingComplete = complete;
  }

  void setPassword(String password) => this.password = password;

  String getCache() {
    var tmp = utf8.encode(subjectID + password);
    var res = sha256.convert(tmp).toString().toUpperCase();
    return res;
  }

  String getSubjectID() => this.subjectID;

  void setSubjectID(String subjectID) => this.subjectID = subjectID;

  int getSettingHour() => this.settingHour;

  void setSettingHour(int settingHour) => this.settingHour = settingHour;

  int getSettingMinute() => this.settingMinute;

  void setSettingMinute(int settingMinute) =>
      this.settingMinute = settingMinute;

  bool getIsSettingComplete() => this.isSettingComplete;

  void setIsSettingComplete(bool isSettingComplete) =>
      this.isSettingComplete = isSettingComplete;

  @override
  String toString() {
    return """ subjectID: $subjectID,
    settingTime: $settingHour: $settingMinute,
    isSettingComplete: $isSettingComplete """;
  }
}
