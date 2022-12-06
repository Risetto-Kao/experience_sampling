import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  var connectivityState = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectivityState);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
    return updateConnectivityState(result);
  }

  Future<void> updateConnectivityState(ConnectivityResult result) async {
    connectivityState.value = result;
  }

  String getHomepageIntroduction(ConnectivityResult result) {
    String stateIntroduction;
    switch (result) {
      case ConnectivityResult.none:
        stateIntroduction = '請先連上網路';
        break;
      case ConnectivityResult.ethernet:
        stateIntroduction = '請維持網路開啟';
        break;
      case ConnectivityResult.wifi:
        stateIntroduction = '請維持網路開啟';
        break;
      case ConnectivityResult.mobile:
        stateIntroduction = '請維持網路開啟';
        break;
      default:
        stateIntroduction = '網路可能有問題';
    }
    return '''親愛的參與者您好：
■ 您每天會收到８個題組，請留意訊號通知，收到後請盡量立刻作答。
■ 請在５分鐘內開始作答，並在５分鐘內作答完畢。
■ 請盡量隨身攜帶手機，並$stateIntroduction。
■ 為確保得到真實的心理學研究成果，請您務必仔細且誠實作答，且作答率越高越好。
■ 祝您有個美好的一天。''';

  }
}
