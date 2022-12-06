import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/logic/general/connectivity_controller.dart';
import 'package:experience_sampling/logic/general/new_notification_controller.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

import 'presentation/router/route_config.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  Get.put(NotificationAPIController());
  Get.put(ConfigController());
  Get.put(ConnectivityController());
  runApp(ESMApp());
}

class ESMApp extends StatefulWidget {
  const ESMApp({Key? key}) : super(key: key);

  @override
  State<ESMApp> createState() => _ESMAppState();
}

class _ESMAppState extends State<ESMApp> {
  bool _isFirstLaunch = false;
  String initialRoute = RouteConfig.questionnaire;
  @override
  void initState() {
    SharedPreferences.getInstance().then((sharedPref) =>
        _isFirstLaunch = sharedPref.getBool("isFirstLaunch") ?? true);
    debugPrint(_isFirstLaunch.toString());
    if (_isFirstLaunch) initialRoute = RouteConfig.homepage;
    super.initState();
    LocalStorage().writeLog("app launched");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: RouteConfig.getPages,
      theme: ThemeData(
          primaryColor: primaryColor, secondaryHeaderColor: secondaryColor),
    );
  }
}
