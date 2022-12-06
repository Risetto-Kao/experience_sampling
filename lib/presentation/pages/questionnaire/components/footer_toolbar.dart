import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/questionnaire/question_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/footer_button.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';

class FooterToolbar extends StatelessWidget {
  final QuestionController questionController = Get.find();
  final QuestionnaireController questionnaireController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQueryWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => LastButton(
              isDisabled: questionnaireController.currentIndex.value == 1,
              onPressed: () => questionnaireController.toLastQuestion(),
            ),
          ),
          SizedBox(
            width: getMediaQueryWidth(context) * 0.5,
          ),
          Obx(
            () => NextButton(
              isDisabled: !questionController.isAnswerComplete(
                  questionType: questionController.question.value.questionType,
                  subOptions: questionController.question.value.subOptions,
                  userAnswer: questionController.userAnswer.value,
                  userSubAnswer: questionController.userSubAnswer.value,
                  multipleUserAnswer: questionController.multipleUserAnswer),
              onPressed: () async {
                await questionnaireController.saveNewResponse();
                questionnaireController.toNextQuestion();
              },
            ),
          ),
        ],
      ),
    );
  }
}
