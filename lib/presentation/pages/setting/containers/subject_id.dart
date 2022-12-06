import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';

import 'package:experience_sampling/presentation/reuse_util/show_information.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class ShowSubjectID extends StatelessWidget {
  final configController = Get.find<ConfigController>();

  final TextEditingController subjectIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          leading: Container(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            color: primaryColor,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '受試者編號',
                style: TextStyle(color: primaryColor),
              ),
              Obx(
                () => Text(configController.subjectID.value),
              ),
            ],
          ),
          onTap: () => setSubjectID(
                isSettingCompleted: configController.isSettingCompleted.value,
              )),
    );
  }

  void setSubjectID({isSettingCompleted}) async {
    if (isSettingCompleted) {
      ShowInformation().canNotModify();
    } else {
      Get.defaultDialog(
        title: '請輸入受試者編號',
        content: TextField(
          controller: subjectIDController,
        ),
        actions: [
          TextButton(
            child: Text('確認'),
            onPressed: () {
              configController.subjectID.value = subjectIDController.text;
              subjectIDController.clear();
              Get.back(result: true);
            },
          ),
        ],
      );
    }
  }
}
