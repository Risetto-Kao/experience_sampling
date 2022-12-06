import 'package:get/get.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';

class AnswerIntroController extends GetxController {
  var answerIntroStatus = (AnswerIntroStatus.GENERAL).obs;

  void setAnswerIntroStatus(AnswerIntroStatus status) =>
      answerIntroStatus.value = status;
  AnswerIntroStatus get currentStatus => answerIntroStatus.value;
}
