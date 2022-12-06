import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/logic/general/connectivity_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class QuestionnaireFinished extends StatelessWidget {
  final QuestionnaireController questionnaireController = Get.find();
  final ConnectivityController connectivityController = Get.find();
  // final NotificationController notificationController = Get.find();
  final ConfigController configController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '本次問卷到此結束',
            style: TextStyle(
                fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.done,
            size: 50,
          ),
          MaterialButton(
            color: secondaryColor,
            // TODO: get finish time
            onPressed: () async {
              questionnaireController.stopQ();
              questionnaireController
                  .updateState(QuestionnaireState.invalidTime);
              if (questionnaireController.isTestMode.value) {
                questionnaireController.toNormal();
                configController.startExp();
                return;
              }
              await questionnaireController.saveNewResponse();
              await questionnaireController.sendNewResponses();
              print("save and send success");
              if (configController.notificationID >= 55) {
                configController.endExp();
                LocalStorage().writeLog("end exp");
              }
            },
            child: Text('結束',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
