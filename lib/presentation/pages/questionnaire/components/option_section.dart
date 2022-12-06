import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/multiple_likert.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/single_answer.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/containers/single_answer_dropdown.dart';

class OptionSection extends StatelessWidget {
  final String? questionType;

  const OptionSection({Key? key, required this.questionType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (questionType == 'SINGLE_ANSWER') return SingleAnswer();
    if (questionType == 'MULTIPLE_LIKERT') return MultipleLikert();
    if (questionType == 'SINGLE_ANSWER_DROPDOWN') return SingleAnswerDropdown();
    return Text('Error: Question Type is NOT Defined');
  }
}
