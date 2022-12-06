import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:experience_sampling/data/apis/status_api.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/repositories/questionnaire_repository.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/logic/general/connectivity_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/reuse_util/new_notification.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/reuse_util/show_information.dart';
import 'package:experience_sampling/presentation/router/route_config.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';
import 'package:experience_sampling/presentation/styles/text_styles.dart';

class SettingToolBar extends StatelessWidget {
  final configController = Get.find<ConfigController>();
  final questionnaireController = Get.put(QuestionnaireController());

  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            width: getMediaQueryWidth(context) * 0.25,
            margin: const EdgeInsets.all(10.0),
            child: TextButton(
                child: Text(
                  '測試通知',
                  style: saveTextStyle,
                ),
                onPressed: () {
                  // todo: send test notification
                  NotificationApi.showNotification(
                      title: "測試通知", body: "請確認您的聲音與震動是否有開啟");
                  LocalStorage().writeLog(
                      "${LogTag.config}, ${LogSubTag.done}, Has tested notification");
                }),
          ),
          Container(
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: const EdgeInsets.all(10.0),
            width: getMediaQueryWidth(context) * 0.25,
            child: TextButton(
                child: Text(
                  '儲存',
                  style: saveTextStyle,
                ),
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool("isFirstLaunch", false);
                  bool isCacheValid = await StatusAPI().isCacheValid(
                      configController.subjectID.value, configController.cache);
                  // todo: check password is valid
                  if (!configController.hasBeenComplete()) {
                    ShowInformation.customSnackbar(
                        title: "錯誤", message: "請先填寫完整");
                  } else if (!isCacheValid) {
                    ShowInformation.customSnackbar(
                        title: "錯誤", message: "編號或密碼錯誤");
                  } else {
                    saveConfig();
                    LocalStorage().writeLog(
                        "${LogTag.config}, ${LogSubTag.done}, Has save config");
                  }
                }),
          ),
          Obx(
            () {
              if (configController.status == ExpStatus.NOT_STARTED) {
                return Container(
                  width: getMediaQueryWidth(context) * 0.25,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: configController.isSettingCompleted.value
                          ? Colors.green
                          : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: TextButton(
                    child: Text(
                      '開始試填',
                      style: saveTextStyle,
                    ),
                    onPressed: () {
                      if (connectivityController.connectivityState.value ==
                          ConnectivityResult.none) {
                        Get.snackbar('網路問題', '請先連上網路',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 2));
                        LocalStorage().writeLog(
                            "${LogTag.config}, ${LogSubTag.done}, no internet");
                        return;
                      }
                      LocalStorage().writeLog(
                          "${LogTag.config}, ${LogSubTag.done}, questionnaire download");
                      questionnaireController.toTestMode();
                      Get.toNamed(RouteConfig.testQ);
                    },
                  ),
                );
              }

              return Container(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void saveConfig() {
    ShowInformation.customDialog(
      title: '請注意！輸入後無法更改',
      content: TextButton(
        child: Text('確認'),
        onPressed: () async {
          await configController.saveDefaultConfig();
          print(DefaultConfig.getInstance().toString());
          Get.back();
          ShowInformation.customSnackbar(title: '儲存狀態', message: '已儲存初始設定');
        },
      ),
    );
  }
}
