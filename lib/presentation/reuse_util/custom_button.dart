import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class SimpleTextButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;

  const SimpleTextButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}

class RouterButton extends StatelessWidget {
  final String text;
  final String path;

  const RouterButton({Key? key, required this.text, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      onPressed: () => Get.toNamed(path),
    );
  }
}
