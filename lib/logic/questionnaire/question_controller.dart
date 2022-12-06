import 'package:get/get.dart';
import 'package:experience_sampling/data/models/answer.dart';
import 'package:experience_sampling/data/models/question.dart';

// get a Question Object from QuestionnaireController
// send next Question index to QuestionnaireController
class QuestionController extends GetxController {
  var userAnswer = 0.obs;
  var userSubAnswer = ''.obs;
  var multipleUserAnswer = List.filled(8, 0).obs;
  var question = Question().obs;
  var answerObject = Answer().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateUserAnswer(int newAnswer) {
    if (newAnswer != 0) userAnswer.value = newAnswer;
  }

  void updateMultipleUserAnswer(int newAnswer, int index) {
    if (newAnswer != 0) multipleUserAnswer[index] = newAnswer;
  }

  void initializeAnswers() {
    userAnswer.value = 0;
    userSubAnswer.value = '';
    multipleUserAnswer.value = List.filled(8, 0);
  }

  void resetAnswer(Answer answer) {
    print("resetAnswer:${answer.multipleUserAnswer}");
    userAnswer.value = answer.userAnswer ?? 0;
    userSubAnswer.value = answer.userSubAnswer ?? "";
    multipleUserAnswer.value = answer.multipleUserAnswer ?? List.filled(8, 0);
    print("resetAnswer:${multipleUserAnswer}");
  }

  void updateQuestion(Question newQuestion) => question.value = newQuestion;
  void updateAnswer(Answer answer) => answerObject.value = answer;

  bool isMultiUserAnswerNull(int subQuestionIndex) =>
      multipleUserAnswer[subQuestionIndex] == 0;

  bool hasSubOption(int index) =>
      question.value.subOptions[index.toString()] != null;

  bool isElseOption(int index) =>
      question.value.subOptions[index.toString()] == 'else';

  dynamic currentSubOptions(int index) =>
      question.value.subOptions[index.toString()];

  int get optionsLength => question.value.options!.length;

  bool get isUserAnswerNull => userAnswer.value == 0;

  bool isAnswerComplete(
      {required String? questionType,
      required int? userAnswer,
      required String? userSubAnswer,
      required Map? subOptions,
      required List? multipleUserAnswer}) {
    if (questionType == 'MULTIPLE_LIKERT') {
      try {
        for (var e in multipleUserAnswer!) {
          if (e == 0) return false;
        }
      } catch (e) {
        return true;
      }

      return true;
    }
    // return !(multipleUserAnswer!.contains(0));
    if (userAnswer == 0) return false;
    if (subOptions?[userAnswer.toString()] != null && userSubAnswer == '') {
      return false;
    }
    return true;
  }

  int getNextIndex() {
    if (question.value.questionType == 'MULTIPLE_LIKERT')
      return question.value.skip?['${multipleUserAnswer[0]}'];
    else
      // ! may crash because of the type of userAnswer
      return question.value.skip?['${userAnswer.value}'];
  }

  // TODO: save user answer
  Answer generateCurrentAnswerObject() {
    answerObject.value = Answer(
        questionIndex: question.value.questionIndex,
        questionType: question.value.questionType);

    if (question.value.questionType != 'MULTIPLE_LIKERT') {
      answerObject.value.userAnswer = userAnswer.value;
      answerObject.value.userSubAnswer = userSubAnswer.value;
      answerObject.value.userAnswerString =
          question.value.options?[userAnswer.value.toString()];
    } else {
      answerObject.value.multipleUserAnswer = <int>[...multipleUserAnswer];
      answerObject.value.multipleUserAnswerString = multipleUserAnswer
          .map((e) => question.value.options![e.toString()])
          .cast<String>()
          .toList();
    }
    return answerObject.value;
  }
}
