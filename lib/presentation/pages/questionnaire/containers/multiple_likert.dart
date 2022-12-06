import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/questionnaire/question_controller.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/components/vertical_text.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class MultipleLikert extends StatelessWidget {
  final QuestionController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getMediaQueryHeight(context),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(child: ShowOptionsText(), flex: 4),
          Expanded(
            flex: 6,
            child: ListView.separated(
              itemCount: controller.question.value.subQuestion?.length,
              itemBuilder: (context, index) => SubQuestionListTile(
                subQuestionIndex: index,
              ),
              separatorBuilder: (_, __) => Divider(),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowOptionsText extends StatelessWidget {
  final QuestionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: getMediaQueryWidth(context) * 0.05,
            ),
            ...controller.question.value.options!.entries
                .map((e) =>
                    VerticalText(subOptionIndex: e.key, subOptionText: e.value))
                .toList()
          ],
        ));
  }
}

class SubQuestionListTile extends StatelessWidget {
  final QuestionController controller = Get.find();
  final int subQuestionIndex;

  SubQuestionListTile({Key? key, required this.subQuestionIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            controller
                .question.value.subQuestion['${subQuestionIndex + 1}'], // 1-8
            style: TextStyle(fontSize: 15),
          ),
          Container(
            child: Row(
              children: controller.question.value.options!.entries
                  .map(
                    (e) => Obx(
                      () => Radio<int>(
                        activeColor: primaryColor,
                        toggleable: true,
                        value: int.parse(e.key),
                        groupValue: controller
                                .isMultiUserAnswerNull(subQuestionIndex)
                            ? null
                            : controller.multipleUserAnswer[subQuestionIndex],
                        onChanged: (value) =>
                            controller.updateMultipleUserAnswer(
                                value ?? 0, subQuestionIndex),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
