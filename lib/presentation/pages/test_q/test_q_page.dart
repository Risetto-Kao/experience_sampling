import 'package:flutter/material.dart';
// import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/questionnaire_page.dart';

class TestQPage extends StatelessWidget {
  final configController = Get.put(ConfigController());
  final questionnaireController = Get.put(QuestionnaireController());
  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      if (configController.status.value == ExpStatus.NOT_STARTED &&
          questionnaireController.isTestMode.value) {
        // TODO: create a testQ for this one
        return QuestionnaireSection();
      } else {
        // TODO: can't do testQ
        LocalStorage().writeLog(
            "${LogTag.questionnaire}, ${LogSubTag.done}, Has done test Qusetionnaire");
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Text(
              "已經試填完畢～\n請等待通知於正式填答區填寫問卷",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }));
  }
}
