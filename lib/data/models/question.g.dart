// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    questionIndex: json['questionIndex'] as int,
    questionType: json['questionType'] as String,
    questionText: json['questionText'] as String,
    options: (json['options'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as String),
    ),
    skip: json['skip'] as Map<String, dynamic>,
    subQuestion: json['subQuestion'],
    subOptions: json['subOptions'],
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionIndex': instance.questionIndex,
      'questionType': instance.questionType,
      'questionText': instance.questionText,
      'options': instance.options,
      'skip': instance.skip,
      'subQuestion': instance.subQuestion,
      'subOptions': instance.subOptions,
    };
