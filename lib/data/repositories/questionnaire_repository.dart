import 'dart:convert';

import 'package:experience_sampling/data/apis/questionnaire_api.dart';
import 'package:experience_sampling/data/data_providers/default_questionnaire.dart';

import 'package:experience_sampling/data/models/question.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/presentation/reuse_util/print.dart';

class QuestionnaireRepository {
  final QuestionnaireAPI questionnaireAPI = QuestionnaireAPI();

  QuestionnaireRepository();

  Future<String> getQuestionnaire() async {
    String defaultQ = await questionnaireAPI.getQuestionnaire();
    Map<String, dynamic> qMap = jsonDecode(defaultQ);
    print(qMap['version']);
    return defaultQ;
  }

  Future<void> saveQuestionnaireToLocal(String rawQuestionnaire) async {
    LocalStorage localStorage = LocalStorage(destination: 'raw_questionnaire');
    await localStorage.writeFile(rawQuestionnaire);
    printSuccess("questionnaire saved");
  }

  List<Question> getDefaultQuestions() {
    Map<String, dynamic> questionnaire = jsonDecode(defaultQuestionnaire);
    List<Question> questions = <Question>[];
    try {
      List tmp = questionnaire['entity'];
      tmp.forEach((element) {
        // printInYellow("debug element: $element");
        questions.add(Question.fromJson(element));
      });
    } catch (e) {
      printMyError(e);
    }
    return questions;
  }

  Future<List<Question>> getQuestionsFromLocal() async {
    // get raw questionnaire from local
    LocalStorage localStorage = LocalStorage(destination: 'raw_questionnaire');
    String rawQuestionnaire = await localStorage.readFile();

    // decode raw questionnaire
    Map<String, dynamic> questionnaire = jsonDecode(rawQuestionnaire);

    // put raw questionnaire to a model
    List<Question> questions = <Question>[];
    try {
      List tmp = questionnaire['entity'];
      tmp.forEach((e) {
        questions.add(Question.fromJson(e));
      });
    } catch (e) {
      print('Error: Questionnaire to questions failed. $e');
    }
    print("debug : repo questions.length = ${questions.length}");
    return questions;
  }
}
