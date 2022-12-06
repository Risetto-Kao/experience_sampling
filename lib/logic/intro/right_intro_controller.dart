import 'package:get/get.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';

class RightIntroController extends GetxController {
  var rightIntroStatus = (RightIntroStatus.GENERAL).obs;

  void setRightIntroStatus(RightIntroStatus status) =>
      rightIntroStatus.value = status;
  RightIntroStatus get currentStatus => rightIntroStatus.value;
}
