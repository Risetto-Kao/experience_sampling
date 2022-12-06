import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/reuse_util/custom_button.dart';
import 'package:experience_sampling/presentation/router/route_config.dart';

class QuestionnaireAllCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('全部結束啦～請前往歷史頁面確認你這一週來的填答狀況'),
          RouterButton(text: '點此前往歷史頁面', path: RouteConfig.history)
        ],
      ),
    );
  }
}
