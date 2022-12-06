import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class ShowSoundSwitch extends StatelessWidget {
  final configController = Get.find<ConfigController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      child: Obx(
        () => ListTile(
          onTap: () =>
              configController.isMute.value = !(configController.isMute.value),
          leading: configController.isMute.value
              ? Icon(Icons.volume_up)
              : Icon(
                  Icons.volume_off,
                  color: primaryColor,
                ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '開啟 / 關閉通知聲音',
                style: TextStyle(color: primaryColor),
              ),
              Switch(
                inactiveThumbColor: primaryColor,
                inactiveTrackColor: secondaryColor,
                activeColor: primaryColor,
                activeTrackColor: secondaryColor,
                value: configController.isMute.value,
                onChanged: (_) => configController.isMute.value =
                    !(configController.isMute.value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
