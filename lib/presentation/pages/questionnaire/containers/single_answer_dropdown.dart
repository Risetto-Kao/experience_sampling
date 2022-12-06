import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/questionnaire/question_controller.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';
import 'package:experience_sampling/presentation/styles/text_styles.dart';

class SingleAnswerDropdown extends StatelessWidget {
  final QuestionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getMediaQueryHeight(context) * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ShowSubQuestion(),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.question.value.options?.length,
              itemBuilder: (context, index) => DropdownOption(
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowSubQuestion extends StatelessWidget {
  final QuestionController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Map subQuestion = controller.question.value.subQuestion;
    if (subQuestion.isEmpty) return Container();
    return Obx(() {
      if (subQuestion[controller.userAnswer.value.toString()] == null)
        return Container();
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
        child: Text(
          subQuestion[controller.userAnswer.value.toString()],
          style: TextStyle(fontSize: 18),
        ),
      );
    });
  }
}

class DropdownOption extends StatelessWidget {
  final QuestionController controller = Get.find();
  final index;

  DropdownOption({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int textLengthRatio = controller.optionsLength >= 7 ? 10 : 4;
    int totalExpandedRatio = 11;
    int value = index + 1;
    return Container(
      alignment: Alignment.center,
      child: Obx(
        () => InkWell(
          onTap: () => controller.userAnswer.value = value,
          child: Row(
            children: [
              Radio<int>(
                activeColor: primaryColor,
                groupValue: controller.isUserAnswerNull
                    ? null
                    : controller.userAnswer.value,
                value: value,
                onChanged: (value) => controller.updateUserAnswer(value ?? 0),
              ),
              Expanded(
                child: Text(
                  controller.question.value.options?[value.toString()] ??
                      'There is something wrong with the question options',
                ),
                // flex: textLengthRatio
              ),
              Expanded(
                child: DropdownArea(
                  value: value,
                ),
                // flex: totalExpandedRatio - textLengthRatio,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownArea extends StatelessWidget {
  final QuestionController controller = Get.find();

  final int value;

  DropdownArea({Key? key, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    dynamic currentSubOptions = controller.currentSubOptions(value);
    TextEditingController textEditingController = TextEditingController();

    if (currentSubOptions == null)
      return SizedBox(
        width: 1,
      );

    // TODO: Modify 'else' => need to be another tag
    if (currentSubOptions == 'else')
      return Obx(
        () => Visibility(
          visible: value == controller.userAnswer.value,
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[300]),
            onSubmitted: (String elseValue) =>
                controller.userSubAnswer.value = elseValue,
          ),
        ),
      );
    List<dynamic> subOptions = controller.currentSubOptions(value);

    return Obx(
      () => Visibility(
        visible: value == controller.userAnswer.value,
        child: DropdownButton<String>(
          icon: Icon(Icons.arrow_downward),
          isExpanded: true,
          elevation: 100,
          style: dropdownTextStyle,
          dropdownColor: Colors.grey[100],
          hint: Text('請選擇'),
          value: subOptions.contains(controller.userSubAnswer.value)
              ? controller.userSubAnswer.value
              : null,
          items: subOptions
              .map<DropdownMenuItem<String>>(
                (subOption) => DropdownMenuItem<String>(
                  child: Text(
                    subOption,
                    style: TextStyle(color: Colors.black),
                  ),
                  value: subOption,
                ),
              )
              .toList(),
          onChanged: (String? newSubAnswer) {
            controller.userSubAnswer.value = newSubAnswer ?? subOptions[0];
          },
        ),
      ),
    );
  }
}
