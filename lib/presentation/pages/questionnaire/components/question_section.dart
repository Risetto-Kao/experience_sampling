import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/text_styles.dart';

class QuestionSection extends StatelessWidget {
  final String? questionText;

  const QuestionSection({Key? key, required this.questionText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      // width: getMediaQueryWidth(context) * 0.8,
      height: getMediaQueryHeight(context) * 0.4,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
          questionText ?? 'something get wrong at rendering question text',
          style: questionTextStyle),
    );
  }
}
