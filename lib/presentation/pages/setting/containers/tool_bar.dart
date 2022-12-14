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
                  '????????????',
                  style: saveTextStyle,
                ),
                onPressed: () {
                  // todo: send test notification
                  NotificationApi.showNotification(
                      title: "????????????", body: "?????????????????????????????????????????????");
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
                  '??????',
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
                        title: "??????", message: "??????????????????");
                  } else if (!isCacheValid) {
                    ShowInformation.customSnackbar(
                        title: "??????", message: "?????????????????????");
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
                      '????????????',
                      style: saveTextStyle,
                    ),
                    onPressed: () {
                      if (connectivityController.connectivityState.value ==
                          ConnectivityResult.none) {
                        Get.snackbar('????????????', '??????????????????',
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
      title: '?????????????????????????????????',
      content: TextButton(
        child: Text('??????'),
        onPressed: () async {
          await configController.saveDefaultConfig();
          print(DefaultConfig.getInstance().toString());
          Get.back();
          ShowInformation.customSnackbar(title: '????????????', message: '?????????????????????');
        },
      ),
    );
  }
}
