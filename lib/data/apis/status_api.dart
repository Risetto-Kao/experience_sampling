import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StatusAPI {
  var dio = Dio();

  Future<dynamic> getStatus(String subjectID, String cache) async {
    LocalStorage()
        .writeLog("${LogTag.api}, ${LogSubTag.call}, getStatus called");
    var body = [
      {"subjectID": subjectID, "cache": cache}
    ];
    Response response = await dio.post(dotenv.env['url_getstatus'] ?? "",
        data: jsonEncode(body));

    // get questionnaire failed
    if (response.statusCode != 200) {
      LocalStorage()
          .writeLog("${LogTag.api}, ${LogSubTag.call}, getStatus failed");
      return;
    }
    // get questionnaire success
    Map rawStatus = response.data;
    var result = rawStatus['result'];

    LocalStorage()
        .writeLog("${LogTag.api}, ${LogSubTag.response}, getStatus success");
    return result;
  }

  Future<bool> isCacheValid(String subjectID, String cache) async {
    LocalStorage()
        .writeLog("${LogTag.api}, ${LogSubTag.call}, isValidCache called");
    var body = [
      {"subjectID": subjectID, "cache": cache}
    ];
    Response response = await dio.post(dotenv.env['url_getstatus'] ?? "",
        data: jsonEncode(body));

    // get questionnaire failed
    if (response.statusCode != 200) {
      LocalStorage()
          .writeLog("${LogTag.api}, ${LogSubTag.call}, isValidCache failed");
      return false;
    }
    // get questionnaire success
    Map rawStatus = response.data;
    print(rawStatus);
    bool result = rawStatus['error'] == null;

    LocalStorage()
        .writeLog("${LogTag.api}, ${LogSubTag.response}, isValidCache success");
    return result;
  }
}
