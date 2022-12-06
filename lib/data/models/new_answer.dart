import 'package:experience_sampling/data/models/answer.dart';

class NewAnswer {
  String questionIndex = "";
  int? primaryAnswer;
  String? primaryAnswerString;
  String? secondaryAnswer;

  NewAnswer(
      {required this.questionIndex,
      this.primaryAnswer,
      this.primaryAnswerString,
      this.secondaryAnswer});

  NewAnswer.fromAnswer(Answer answer) {
    this.questionIndex = answer.questionIndex.toString();
    this.primaryAnswer = answer.userAnswer;
    this.primaryAnswerString = answer.userAnswerString;

    if (answer.multipleUserAnswerString != null) {
      String listAnswer = "";
      answer.multipleUserAnswerString?.forEach((element) {
        listAnswer = listAnswer + element + ",";
      });
      this.secondaryAnswer = listAnswer;
    } else {
      this.secondaryAnswer = answer.userSubAnswer;
    }
  }

  factory NewAnswer.fromJson(Map<String, dynamic> json) {
    return NewAnswer(
        questionIndex: json['questionIndex'] as String,
        primaryAnswer: json['primaryAnswer'] as int?,
        primaryAnswerString: json['primaryAnswerString'] as String?,
        secondaryAnswer: json['secondaryAnswer'] as String?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'questionIndex': this.questionIndex,
      'primaryAnswer': this.primaryAnswer,
      'primaryAnswerString': this.primaryAnswerString,
      'secondaryAnswer': this.secondaryAnswer,
    };
  }
}
