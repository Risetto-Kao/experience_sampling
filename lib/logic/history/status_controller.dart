import 'package:get/get.dart';
import 'package:experience_sampling/data/apis/status_api.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';

class StatusController extends GetxController {
  var statusList = <String>[].obs;
  var statusCount = Map().obs;
  var index = 3;
  var isDataLoaded = false.obs;

  void setStatusList() async {
    var config = DefaultConfig.getInstance();
    String subjectID = config.getSubjectID();
    String cache = config.getCache();
    List allStatus = await StatusAPI().getStatus(subjectID, cache);

    List<String> _statuses = List<String>.filled(56, "not_yet");
    try {
      for (var o in allStatus) {
        var index = o["filledCount"];
        if (index >= 56) continue;
        _statuses[index] = o["status"];
      }
    } catch (e) {
      print("error: $e");
      LocalStorage().writeLog("status show error: $e");
    }

    statusList.value = _statuses;
    _initStatus();
    isDataLoaded.value = true;
  }

  @override
  void onInit() {
    setStatusList();
    super.onInit();
  }

  void _initStatus() {
    statusCount.clear();
    print(statusList.length);
    statusList.forEach((element) {
      if (statusCount.containsKey(element))
        statusCount[element] += 1;
      else
        statusCount[element] = 1;
    });
  }
}
