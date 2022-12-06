import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/logic/questionnaire/questionnaire_controller.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/state_view/questionnaire_all_completed.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/state_view/questionnaire_finished.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/state_view/questionnaire_initial.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/state_view/questionnaire_invalid_time.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/state_view/questionnaire_loaded.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/state_view/questionnaire_remind_over_time.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/state_view/questionnaire_started.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class QuestionnaireSection extends StatelessWidget {
  final QuestionnaireController questionnaireController =
      Get.put(QuestionnaireController());
  final ConfigController configController = Get.put(ConfigController());
  @override
  Widget build(BuildContext context) {
    // configController.launchQuestionnairePage();
    return Obx(
      () {
        switch (questionnaireController.state.value) {
          case QuestionnaireState.initial:
            return QuestionnaireInitial();

          case QuestionnaireState.invalidTime:
            return QuestionnaireInvalidTime();

          case QuestionnaireState.loading:
            return Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));

          case QuestionnaireState.loaded:
            return QuestionnaireLoaded();

          case QuestionnaireState.finished:
            return QuestionnaireFinished();

          case QuestionnaireState.remindOverTime:
            return QuestionnaireRemindOverTime();

          case QuestionnaireState.allCompleted:
            return QuestionnaireAllCompleted();

          case QuestionnaireState.started:
            return QuestionnaireStarted();
          default:
            return QuestionnaireLoaded();
        }
      },
    );
  }
}
