import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/data/storages/shared_preference_util.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/constants/introduction.dart';
import 'package:experience_sampling/presentation/reuse_util/print.dart';

class DPStatusController extends GetxController {
  static const platform = const MethodChannel(dpMethodChannel);

  var dpStatus = DPStatus.notStarted.obs;

  @override
  void onInit() {
    // TODO: get DP status from local storage or config
    dpStatus.value = DPStatus.notStarted;
    super.onInit();
  }

  void changeDPStatus(DPStatus status) {
    if (status == DPStatus.agree)
      startDPservice();
    else if (status == DPStatus.disagree && dpStatus.value == DPStatus.agree)
      stopDPservice();
    dpStatus.value = status;
  }

  /// get dp current status and return correspond introduction
  /// e.g. agree => "實驗狀態：本實驗進行中"
  String getDPStatusText(DPStatus status) {
    switch (status) {
      case DPStatus.notStarted:
        return DPIntroduction.notStarted;
      case DPStatus.agree:
        return DPIntroduction.agree;
      case DPStatus.disagree:
        return DPIntroduction.disagree;
      default:
        return DPIntroduction.error;
    }
  }

  Future<void> startDPservice() async {
    try {
      String subjectID = await readFromSharedPreferences(
          DefaultConfigString.subjectID, String);
      await platform.invokeMethod('startBackService', {'subjectID': subjectID});
      printSuccess('Start dp success');
    } on PlatformException catch (e) {
      printMyError('Fail at start dp: ${e.message}');
    }
  }

  Future<void> stopDPservice() async {
    try {
      // TODO: if the subject wanna quit dp part, disconnect with native code
      printSuccess('Stop dp success');
    } on PlatformException catch (e) {
      printMyError('Fail at stop dp: ${e.message}');
    }
  }
}
