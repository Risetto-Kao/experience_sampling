import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/history/status_controller.dart';
import 'package:experience_sampling/presentation/pages/history/components/daily_status.dart';

class ShowWeeklyStatus extends StatelessWidget {
  final StatusController controller = Get.put(StatusController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () {
          if (!controller.isDataLoaded.value)
            return Column(
              children: [
                Text("請確保網路開啟"),
                CircularProgressIndicator(),
              ],
            );
          return Column(
            children: [
              for (int i = 0; i < 7; i++)
                ShowDailyStatus(
                    date: '第 ${i * 8 + 1} 次',
                    dailyStatus:
                        controller.statusList.sublist(i * 8, (i + 1) * 8)),
            ],
          );
        },
      ),
    );
  }
}
