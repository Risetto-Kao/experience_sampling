import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';
import 'package:experience_sampling/presentation/styles/text_styles.dart';

class LastButton extends StatelessWidget {
  final bool isDisabled;
  final GestureTapCallback onPressed;

  LastButton({Key? key, required this.onPressed, required this.isDisabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getMediaQueryHeight(context)*0.2,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      // color: primaryColor,
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        child: Text('上一題', style: footerButtonTextStyle),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final bool isDisabled;
  final GestureTapCallback onPressed;

  NextButton({Key? key, required this.onPressed, required this.isDisabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        child: Text('下一題', style: footerButtonTextStyle),
      ),
    );
  }
}
