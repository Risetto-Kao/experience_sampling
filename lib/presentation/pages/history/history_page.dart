import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/history/status_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/pages/history/containers/show_status_statistic.dart';
import 'package:experience_sampling/presentation/pages/history/containers/show_weekly_status.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

// TODO: Optimize: record when the subject started the experiment => adjust showing weekly status

class HistorySection extends StatelessWidget {
  final controller = Get.put(StatusController());
  final QuestionnaireController questionnaireController =
      Get.put(QuestionnaireController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            margin: const EdgeInsets.all(20.0),
            child: Text(
              '問卷填寫紀錄',
              style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            )),
        TextButton(
          onPressed: () async {
            bool res = await questionnaireController.sendLocalFiles();
            if (res) {
              controller.setStatusList();
              Get.snackbar("重新整理", "資料為最近狀態");
            } else {
              Get.snackbar("重新整理", "資料並未更新，請檢查網路狀態或為最新狀態");
            }
          },
          child: Text('重新整理'),
        ),
        ShowStatusStatistic(),
        Divider(),
        ShowWeeklyStatus(),
      ]),
    );
  }
}
