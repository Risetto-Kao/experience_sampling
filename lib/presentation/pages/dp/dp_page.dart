import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/dp/dp_status_controller.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/constants/introduction.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class DPSection extends StatelessWidget {
  final controller = Get.put(DPStatusController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                '【數位足跡】隱私權權限',
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            child: Text(
              welcomedpText,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              dpIntroductionText,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: primaryColor,
              thickness: 1.0,
            ),
          ),
          Container(
            child: Text(
              onlyForResearch,
              style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              dpIntroAgreeText,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              dpQuitIntroduction,
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Obx(
              () => Text(
                controller.getDPStatusText(controller.dpStatus.value),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.dpStatus.value == DPStatus.notStarted,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: TextButton(
                  onPressed: () => controller.changeDPStatus(DPStatus.agree),
                  child: Text(
                    dpAgreeText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.dpStatus.value == DPStatus.agree,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: TextButton(
                  child: Text(
                    dpStopText,
                    style: TextStyle(color: Colors.white),
                  ),
                  // TODO: Use Get.Dialog to Customize the dialog for confirming like the above
                  onPressed: () => controller.changeDPStatus(DPStatus.disagree),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
