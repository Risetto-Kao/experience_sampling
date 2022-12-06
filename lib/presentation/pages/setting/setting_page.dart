import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/presentation/constants/introduction.dart';
import 'package:experience_sampling/presentation/pages/setting/components/category_title.dart';
import 'package:experience_sampling/presentation/pages/setting/containers/setting_time.dart';
import 'package:experience_sampling/presentation/pages/setting/containers/subject_id.dart';
import 'package:experience_sampling/presentation/pages/setting/containers/tool_bar.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'containers/subject_password.dart';

class SettingSection extends StatelessWidget {
  final configController = Get.put(ConfigController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowCategoryTitle(titleText: initialSettingText),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  ShowSubjectID(),
                  Visibility(
                    child: ShowSubjectPassword(),
                    visible: !configController.isSettingCompleted.value,
                  ),
                  ShowSettingTime(),
                ],
              ),
            ),
            ShowCategoryTitle(titleText: elseText),
            SizedBox(
              height: getMediaQueryHeight(context) * 0.1,
            ),
            SettingToolBar(),
          ],
        ),
      ),
    );
  }
}
