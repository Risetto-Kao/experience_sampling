import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/questionnaire/question_controller.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/components/footer_toolbar.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/components/option_section.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/components/question_section.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/questionnaire_text_title.dart';

class QuestionnaireLoaded extends StatelessWidget {
  final questionController = Get.put(QuestionController());
  QuestionnaireLoaded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(questionController.question.value.toString());
    return Column(
      children: [
        QuestionnaireTextTitle(),
        //? better: expanded with the word size
        Expanded(
          child: Obx(
            () => QuestionSection(
                questionText: questionController.question.value.questionText),
          ),
          flex: 6,
        ),
        Expanded(
          child: Obx(
            () => OptionSection(
                questionType: questionController.question.value.questionType),
          ),
          flex: 15,
        ),
        Expanded(
          child: FooterToolbar(),
          flex: 3,
        ),
      ],
    );
  }
}
