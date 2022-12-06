import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/questionnaire/question_controller.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class SingleAnswer extends StatelessWidget {
  final QuestionController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getMediaQueryHeight(context) * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => ListView.builder(
          itemCount: controller.question.value.options?.length,
          itemBuilder: (context, index) => SingleAnswerOption(
            optionIndex: index,
          ),
        ),
      ),
    );
  }
}

class SingleAnswerOption extends StatelessWidget {
  final QuestionController controller = Get.find();
  final int optionIndex;
  SingleAnswerOption({
    Key? key,
    required this.optionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Obx(
        () => RadioListTile<int>(
            dense: true,
            activeColor: primaryColor,
            toggleable: true,
            groupValue: controller.isUserAnswerNull
                ? null
                : controller.userAnswer.value,
            value: optionIndex + 1,
            onChanged: (value) => controller.updateUserAnswer(value ?? 0),
            title: Text(
              controller.question.value.options?['${optionIndex + 1}'] ??
                  'Error: At showing text',
              style: TextStyle(fontSize: 18),
            )),
      ),
    );
  }
}
