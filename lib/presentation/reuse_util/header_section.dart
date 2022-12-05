import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: primaryColor,
      child: Image.asset(
        'assets/images/ntu_psy_logo.png',
        fit: BoxFit.none,
      ),
    );
  }
}
