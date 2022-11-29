import 'package:experience_sampling/presentation/constants/enums.dart';

final List<DPStatus> defaultStatusData = List.filled(56, DPStatus.notStarted);
const lateNotificationFrequency = 4;
const notificationTimeBase = 90;
const notificationTimeGap = 30;

class LogTag {
  // which part
  static const workflow = 'workflow';
  static const questionnaire = 'questionnaire';
  static const answer = 'answer';
  static const presentation = 'presentation';
  static const config = 'config';
  static const connect = 'connect';

  static const notification = 'notification';

  static const api = "api";
}

class LogSubTag {
  // do what
  static const initialize = 'initialize';
  static const update = 'update';
  static const delete = 'delete';
  static const create = 'create';
  static const done = 'done';
  static const save = 'save';
  static const disable = 'disable';

  static const send = "send";

  static const status = "status";

  static const call = "call";

  static const response = "response";

  static const close = "close";

  static const index = "index";

  static const listen = "listen";
}

class DefaultConfigString {
  static const subjectID = 'subjectID';
  static const notificationID = 'notificationID';
  static const showSettingTime = 'showSettingTime';
  static const settingStartTime = 'settingStartTime';
  static const isESMStarted = 'isESMStarted';
  static const isMute = 'isMute';
  static const launchTimes = 'launchTimes';
}

class DefaultValue {
  static const subjectID = 'S000';
  static const settingStartTime = '__:__';
  static const isMute = false;
  static const isESMStarted = false;
}

const dpMethodChannel = 'digital_phenotyping';

class DrawerInfo {
  final String title;
  final String imagePath;
  final String routeName;

  DrawerInfo(this.title, this.imagePath, this.routeName);
}

class ImagePath {
  static const APP_ICON = 'assets/images/' + 'app_icon' + '.png';
  static const BOOK_OPEN = 'assets/images/' + 'book_open' + '.png';
  static const CHECK_CIRCLE = 'assets/images/' + 'check_circle' + '.png';
  static const CLOCK = 'assets/images/' + 'clock' + '.png';
  static const EDIT_PURPLE = 'assets/images/' + 'edit' + '.png';
  static const EDIT = 'assets/images/' + 'edit' + '.png';
  static const HOME = 'assets/images/' + 'home' + '.png';
  static const INTRO_PICTURE1 = 'assets/images/' + 'intro_picture1' + '.png';
  static const INTRO_PICTURE2 = 'assets/images/' + 'intro_picture2' + '.png';
  static const INTRO_PICTURE3 = 'assets/images/' + 'intro_picture3' + '.png';
  static const MAIL = 'assets/images/' + 'mail' + '.png';
  static const MAP_PIN = 'assets/images/' + 'map_pin' + '.png';
  static const NTU_PSY_LOGO = 'assets/images/' + 'ntu_psy_logo' + '.png';
  static const SETTINGS = 'assets/images/' + 'settings' + '.png';
  static const CALENDAR = 'assets/images/' + 'calendar' + '.png';
  static const LAB_ICON = 'assets/images/' + 'lab_icon' + '.png';
}

class ConfigValue {
  static const overTime = 5; // in minutes
}
