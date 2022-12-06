import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class QuestionnaireTextTitle extends StatelessWidget {
  const QuestionnaireTextTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Text(
        '填寫問卷',
        style: TextStyle(
            color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
