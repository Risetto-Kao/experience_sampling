import 'package:experience_sampling/presentation/constants/enums.dart';

class OnceConfig {
  ExpStatus expStatus;
  int notificationID;
  bool isValidTime;
  static OnceConfig _instance = OnceConfig._();

  factory OnceConfig.getInstance() {
    return OnceConfig._instance;
  }
  // static OnceConfig _instance = OnceConfig._();

  ExpStatus getExpStatus() => this.expStatus;

  void setExpStatus(ExpStatus expStatus) => this.expStatus = expStatus;

  int getNotificationID() => notificationID;

  void setNotificationID(int notificationID) =>
      this.notificationID = notificationID;

  bool getIsValidTime() => this.isValidTime;

  void setIsValidTime(bool isValidTime) => this.isValidTime = isValidTime;

  void update(ExpStatus status, int nid, bool valid) {
    expStatus = status;
    notificationID = nid;
    isValidTime = valid;
  }

  OnceConfig._({
    this.expStatus = ExpStatus.NOT_STARTED,
    this.notificationID = -1,
    this.isValidTime = false,
  });

  @override
  String toString() {
    return """
    expStatus: $expStatus,
    notificationID: $notificationID,
    isValidTime: $isValidTime,
    """;
  }
}
