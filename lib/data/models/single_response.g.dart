// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleResponse _$SingleResponseFromJson(Map<String, dynamic> json) {
  return SingleResponse(
    subjectID: json['subjectID'] as String,
    status: json['status'] as String,
    answers: (json['answers'] as List)
        .map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        .toList(),
    notificationID: json['notificationID'] as int,
    filledDateTime: json['filledTime'] == null
        ? null
        : DateTime.parse(json['filledTime'] as String),
    isPostSuccess: json['isPostSuccess'] as bool,
  );
}

Map<String, dynamic> _$SingleResponseToJson(SingleResponse instance) =>
    <String, dynamic>{
      'subjectID':instance.subjectID,
      'status': instance.status,
      'answers': instance.answers,
      'notificationID': instance.notificationID,
      'filledTime': instance.filledDateTime?.toIso8601String(),
      'isPostSuccess': instance.isPostSuccess,
    };
