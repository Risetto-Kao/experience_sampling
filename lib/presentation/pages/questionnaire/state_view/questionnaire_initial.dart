import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';

import 'package:experience_sampling/presentation/reuse_util/custom_button.dart';
import 'package:experience_sampling/presentation/router/route_config.dart';

class QuestionnaireInitial extends StatelessWidget {
  final QuestionnaireController questionnaireController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('尚未下載問卷，請先設定完後，按下「開始實驗」，即可下載問卷'),
          RouterButton(
            text: '前往設定頁面',
            path: RouteConfig.setting,
          ),
        ],
      ),
    );
  }
}
