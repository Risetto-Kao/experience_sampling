import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:flutter_logs/flutter_logs.dart';
import 'package:experience_sampling/data/models/new_response.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AnswerAPI {
  var dio = Dio();

  Future<bool> postAnswers(List<NewResponse> newResponses) async {
    Response response = await dio.post(dotenv.env['url_postanwer'] ?? "",
        data: jsonEncode(newResponses));

    LocalStorage()
        .writeLog("${LogTag.api}, ${LogSubTag.call}, postanswer was called");
    if (response.statusCode != 200) {
      LocalStorage()
          .writeLog("${LogTag.api}, ${LogSubTag.call}, error at postAnswers");
      return false;
    }

    Map rawStatus = response.data;
    if (rawStatus['error'] == null) {
      LocalStorage()
          .writeLog("${LogTag.api}, ${LogSubTag.response}, postanswer success");
      print('Success: postAnswers success');
    } else {
      LocalStorage()
          .writeLog("${LogTag.api}, ${LogSubTag.call}, error at postAnswers");
    }

    return rawStatus['error'] == null;
  }
}
