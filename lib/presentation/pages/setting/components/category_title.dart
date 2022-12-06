import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class ShowCategoryTitle extends StatelessWidget {
  final String titleText;

  const ShowCategoryTitle({Key? key, required this.titleText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text(
        titleText,
        style: TextStyle(
            color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
