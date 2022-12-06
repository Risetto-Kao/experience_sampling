import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/data/models/once_config.dart';
import 'package:experience_sampling/logic/general/new_notification_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/questionnaire_text_title.dart';
import 'package:experience_sampling/presentation/reuse_util/new_notification.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class QuestionnaireStarted extends StatelessWidget {
  final QuestionnaireController questionnaireController =
      Get.put(QuestionnaireController());
  final NotificationAPIController notificationController =
      Get.put(NotificationAPIController());
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          QuestionnaireTextTitle(),
          SizedBox(
            height: getMediaQueryHeight(context) * 0.15,
          ),
          Container(
              margin: const EdgeInsets.all(20.0),
              child: Text(
                '問卷已下載完成，\n請點選下方按鈕開始填寫',
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                questionnaireController.startQ();
                questionnaireController.updateState(QuestionnaireState.loaded);
                NotificationApi.cancelAll();
                int notificationID = OnceConfig.getInstance().notificationID;
                notificationController.sendNext12Notifications(notificationID);
              },
              child: Image.asset(ImagePath.EDIT_PURPLE),
            ),
          ),
        ],
      ),
    );
  }
}
