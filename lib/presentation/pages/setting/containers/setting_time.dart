import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/presentation/reuse_util/show_information.dart';
import 'package:experience_sampling/presentation/reuse_util/util.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class ShowSettingTime extends StatelessWidget {
  final configController = Get.find<ConfigController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 30),
      child: ListTile(
        onTap: () async => setTime(
            context: context,
            isSettingCompleted: configController.isSettingCompleted.value),
        leading: Container(
          child: Icon(
            Icons.access_alarm,
            color: Colors.white,
          ),
          color: primaryColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "設定作答時間",
              style: TextStyle(color: primaryColor),
            ),
            Obx(
              () {
                int sHour = configController.settingHour.value;
                int sMinute = configController.settingMinute.value;
                String showTimeString = Util.showTimeString(sHour, sMinute);
                return Text(showTimeString);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setTime({context, isSettingCompleted}) async {
    print(isSettingCompleted);
    if (isSettingCompleted) {
      ShowInformation().canNotModify();
    } else {
      var timeOfDay = await showTimePicker(
              context: context, initialTime: TimeOfDay.now()) ??
          TimeOfDay(hour: 0, minute: 0);
      configController.settingHour.value = timeOfDay.hour;
      configController.settingMinute.value = timeOfDay.minute;
    }
  }
}
