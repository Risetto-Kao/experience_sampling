import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/history/status_controller.dart';
import 'package:experience_sampling/presentation/pages/history/components/status_item.dart';

class ShowStatusStatistic extends StatelessWidget {
  final StatusController controller = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() => Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                generateStatusItem(
                  'not_yet',
                  controller.statusCount['not_yet'],
                ),
                generateStatusItem(
                  'done',
                  controller.statusCount['done'],
                ),
                generateStatusItem(
                  'pass',
                  controller.statusCount['pass'],
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     generateStatusItem(
            //       'uncomplete',
            //       controller.statusCount['uncomplete'],
            //     ),
            //     generateStatusItem(
            //       'pass',
            //       controller.statusCount['pass'],
            //     ),
            //   ],
            // ),
          ])),
    );
  }
}
