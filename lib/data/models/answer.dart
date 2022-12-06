part 'answer.g.dart';

class Answer {
  int? questionIndex;
  int? userAnswer;
  String? userAnswerString;
  String? userSubAnswer;
  String? questionType;
  List<int>? multipleUserAnswer;
  List<String>? multipleUserAnswerString;
  int? get getQuestionIndex => this.questionIndex;

  set setQuestionIndex(int? questionIndex) =>
      this.questionIndex = questionIndex;

  get getUserAnswer => this.userAnswer;

  set setUserAnswer(userAnswer) => this.userAnswer = userAnswer;

  get getUserAnswerString => this.userAnswerString;

  set setUserAnswerString(userAnswerString) =>
      this.userAnswerString = userAnswerString;

  get getUserSubAnswer => this.userSubAnswer;

  set setUserSubAnswer(userSubAnswer) => this.userSubAnswer = userSubAnswer;

  get getQuestionType => this.questionType;

  set setQuestionType(questionType) => this.questionType = questionType;

  get getMultipleUserAnswer => this.multipleUserAnswer;

  set setMultipleUserAnswer(multipleUserAnswer) =>
      this.multipleUserAnswer = multipleUserAnswer;

  get getMultipleUserAnswerString => this.multipleUserAnswerString;

  set setMultipleUserAnswerString(multipleUserAnswerString) =>
      this.multipleUserAnswerString = multipleUserAnswerString;

  Answer(
      {this.questionIndex,
      this.userAnswer,
      this.userSubAnswer,
      this.userAnswerString,
      this.questionType,
      this.multipleUserAnswer,
      this.multipleUserAnswerString});

  // set resetUserAnswer(bool ) => userAnswer = newAnswer;

  factory Answer.fromJson(Map<String, dynamic> data) => _$AnswerFromJson(data);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  String toString() {
    return '''- Question Index: $questionIndex,
- Qusetion Type: $questionType,
- User Answer: $userAnswer,
- User Answer String: $userAnswerString,
- User SubAsnwer: $userSubAnswer,
- Multiple User Answer: $multipleUserAnswer,
- Multiple User Answer String: $multipleUserAnswerString''';
  }
}
