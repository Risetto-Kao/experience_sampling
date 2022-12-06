import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:experience_sampling/data/data_providers/default_questionnaire.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class QuestionnaireAPI {
  var dio = Dio();

  Future<String> getQuestionnaire() async {
    Map<String, dynamic> questionnaire;
    String cache = DefaultConfig.getInstance().getCache();
    var body = {"cache": cache};
    Response response = await dio.post(dotenv.env['url_getquestionnaire'] ?? "",
        data: jsonEncode(body));
    LocalStorage()
        .writeLog("${LogTag.api}, ${LogSubTag.call}, getQuestionnaire called");

    // get questionnaire failed
    if (response.statusCode != 200) {
      LocalStorage().writeLog(
          "${LogTag.api}, ${LogSubTag.response}, getQuestionnaire fail");
      return defaultQuestionnaire;
    }

    // get questionnaire success
    String rawQuestionnaire = response.data;
    questionnaire = await jsonDecode(rawQuestionnaire);
    LocalStorage().writeLog(
        "${LogTag.api}, ${LogSubTag.response}, getQuestionnaire success");
    // check if the tags of questionnaire
    if (questionnaire['version'] == null) {
      LocalStorage().writeLog(
          "${LogTag.api}, ${LogSubTag.response}, getQuestionnaire fail");
      return defaultQuestionnaire;
    }
    LocalStorage().writeLog(
        "${LogTag.api}, ${LogSubTag.response}, questionnaire has version number ${questionnaire["version"]}");

    return rawQuestionnaire;
  }
}
