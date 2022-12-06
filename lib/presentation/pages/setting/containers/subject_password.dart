import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';

import 'package:experience_sampling/presentation/reuse_util/show_information.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class ShowSubjectPassword extends StatelessWidget {
  final configController = Get.find<ConfigController>();

  final TextEditingController passwordController = TextEditingController();
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
                '受試者密碼',
                style: TextStyle(color: primaryColor),
              ),
              Obx(
                () => Text(configController.password.value),
              ),
            ],
          ),
          onTap: () {
            print(configController.getCache);
            setSubjectPassword(
              isSettingCompleted: configController.isSettingCompleted.value,
            );
          }),
    );
  }

  void setSubjectPassword({isSettingCompleted}) async {
    if (isSettingCompleted) {
      ShowInformation().canNotModify();
    } else {
      Get.defaultDialog(
        title: '請輸入受試者密碼',
        content: TextField(
          controller: passwordController,
        ),
        actions: [
          TextButton(
            child: Text('確認'),
            onPressed: () {
              configController.password.value = passwordController.text;
              passwordController.clear();
              Get.back(result: true);
            },
          ),
        ],
      );
    }
  }
}
