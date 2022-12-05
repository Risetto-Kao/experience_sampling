class Util {
  static String formatDateTime(DateTime time) {
    return "${time.year}/${time.month}/${time.day}-${time.hour}:${time.minute}:${time.second}";
  }

  static String showTimeString(int hour, int minute) {
    String res = "";
    int endHour = hour + 12;
    var strHour = _generateTwoDigitsString(hour);
    var strMinute = _generateTwoDigitsString(minute);

    if (endHour >= 24) {
      endHour -= 24;
      var strEndHour = _generateTwoDigitsString(endHour);
      res = "$strHour:$strMinute ~ 次日 $strEndHour:$strMinute";
    } else {
      var strEndHour = _generateTwoDigitsString(endHour);
      res = "$strHour:$strMinute ~ $strEndHour:$strMinute";
    }
    return res;
  }

  static String _generateTwoDigitsString(int timeUnit) =>
      timeUnit >= 10 ? timeUnit.toString() : '0${timeUnit.toString()}';

  static List<Object> rotate(List<Object> list, int v) {
    if (list.isEmpty || v == 0) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }
}
