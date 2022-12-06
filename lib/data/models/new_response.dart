import 'package:experience_sampling/data/models/new_answer.dart';

class NewResponse {
  String subjectID;
  String cache;
  int filledCount;
  String status;
  String filledTime;
  List<NewAnswer> answers;

  NewResponse(
      {required this.subjectID,
      required this.cache,
      required this.filledCount,
      required this.status,
      required this.filledTime,
      required this.answers});

  factory NewResponse.fromJson(Map<String, dynamic> json) {
    return NewResponse(
      cache: json['cache'] as String,
      subjectID: json['subjectID'] as String,
      filledCount: json['filledCount'] as int,
      status: json['status'] as String,
      filledTime: json['filledTime'] as String,
      answers: (json['answers'] as List)
          .map((e) => NewAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cache': this.cache,
      'subjectID': this.subjectID,
      'filledCount': this.filledCount,
      'status': this.status,
      'filledTime': this.filledTime,
      'answers': this.answers
    };
  }
}
