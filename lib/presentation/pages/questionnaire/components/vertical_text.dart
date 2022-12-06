import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';

class VerticalText extends StatelessWidget {
  final String subOptionIndex;
  final String subOptionText;
  const VerticalText({
    Key? key,
    required this.subOptionIndex,
    required this.subOptionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(subOptionIndex + '. '),
        MongolText.rich(TextSpan(text: subOptionText)),
      ],
    );
  }
}
