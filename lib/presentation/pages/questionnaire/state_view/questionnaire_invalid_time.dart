import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/data/models/once_config.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/questionnaire_text_title.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class QuestionnaireInvalidTime extends StatelessWidget {
  final QuestionnaireController questionnaireController = Get.find();
  final ConfigController configController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionnaireTextTitle(),
        SizedBox(
          height: getMediaQueryHeight(context) * 0.08,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
          child: Text(
            '非填答問卷時間，請於收到通知後，進入本程式完成問卷填答',
            style: TextStyle(
                color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () async {
            // todo after: if shut down, delete the following line.
            OnceConfig.getInstance().setNotificationID(
                await LocalStorage.getCurrentNotificationIDWhenInvalid());
            if (await questionnaireController.isCurrentFileExist()) return;
            await configController.initOnceConfig();
            questionnaireController.initSettings();
          },
          child: Text(
            "重新整理",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
