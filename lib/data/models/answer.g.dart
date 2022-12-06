// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    questionIndex: json['questionIndex'] as int,
    userAnswer: json['userAnswer'] as int,
    userSubAnswer: json['userSubAnswer'] as String,
    userAnswerString: json['userAnswerString'] as String,
    questionType: json['questionType'] as String,
    multipleUserAnswer:
        (json['multipleUserAnswer'] as List).map((e) => e as int).toList(),
    multipleUserAnswerString: (json['multipleUserAnswerString'] as List)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'questionIndex': instance.questionIndex,
      'userAnswer': instance.userAnswer,
      'userAnswerString': instance.userAnswerString,
      'userSubAnswer': instance.userSubAnswer,
      'questionType': instance.questionType,
      'multipleUserAnswer': instance.multipleUserAnswer,
      'multipleUserAnswerString': instance.multipleUserAnswerString,
    };
