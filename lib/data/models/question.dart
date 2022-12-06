
part 'question.g.dart';


class Question {
  int? questionIndex;
  String? questionType;
  String? questionText;
  Map<String, String>? options;
  Map? skip;
  dynamic subQuestion;
  dynamic subOptions;


  // * assert only appears at develop enviroment
  Question(
      { this.questionIndex,
      this.questionType,
      this.questionText,
      this.options,
      this.skip,
      this.subQuestion,
      this.subOptions,
  });
      // : 
      // assert(questionIndex == '', 'Question index is Empty'),
        // assert(questionType == '', 'Qusetion type is Empty'),
        // assert(questionText == '', 'Question text is Empty');

  factory Question.fromJson(Map<String, dynamic> data) =>
      _$QuestionFromJson(data);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
