import 'package:experience_sampling/data/models/answer.dart';

part 'single_response.g.dart';

class SingleResponse {
  String subjectID;
  String status;
  List<Answer?> answers;
  int notificationID;
  DateTime? filledDateTime;
  bool isPostSuccess;

  SingleResponse(
      {required this.subjectID,
      this.status = 'notStarted',
      required this.answers,
      required this.notificationID,
      this.filledDateTime,
      this.isPostSuccess = false});

  set resetPostStatus(bool isSuccessed) => this.isPostSuccess = isSuccessed;

  factory SingleResponse.fromJson(Map<String, dynamic> data) =>
      _$SingleResponseFromJson(data);

  Map<String, dynamic> toJson() => _$SingleResponseToJson(this);

  @override
  String toString() {
    return '''- subjectID: $subjectID,
- status: $status,
- notificationID: $notificationID,
- filledTime: $filledDateTime,
- isPostSuccess: $isPostSuccess,
- fistAnswer: ${answers[0]},
''';
  }
}
