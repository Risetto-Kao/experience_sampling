import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/questionnaire_text_title.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class QuestionnaireRemindOverTime extends StatelessWidget {
  final QuestionnaireController questionnaireController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          QuestionnaireTextTitle(),
          SizedBox(
            height: getMediaQueryHeight(context) * 0.1,
          ),
          Image.asset(ImagePath.CLOCK),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 80),
            child: Text(
              '本次問卷超過${ConfigValue.overTime}分鐘，\n下次問卷填答請於${ConfigValue.overTime}分鐘內完成',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: getMediaQueryHeight(context) * 0.1,
          ),
          Container(
            width: getMediaQueryWidth(context) * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: primaryColor),
            child: TextButton(
              onPressed: () => questionnaireController
                  .updateState(QuestionnaireState.finished),
              child: Text(
                '確認',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
