import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:experience_sampling/data/models/answer.dart';
import 'package:experience_sampling/data/models/new_response.dart';
import 'package:experience_sampling/data/models/single_response.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  final String destination;
  LocalStorage({this.destination = 'default'});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> isExist() async {
    final path = await _localPath;
    return File('$path/$destination.json').exists();
  }

  Future<File> get _localFileJson async {
    final path = await _localPath;
    return File('$path/$destination.json');
  }

  Future<File> get _localFileTxt async {
    final path = await _localPath;
    return File('$path/$destination.txt');
  }

  Future<File> get _logTxt async {
    final path = await _localPath;
    return File('$path/log.txt');
  }

  Future<String> get logFilePath async {
    final path = await _localPath;
    return '$path/log.txt';
  }

  Future<File> writeFile(dynamic content) async {
    final encodedData = content;
    final file = await _localFileTxt;

    return file.writeAsString(encodedData);
  }

  Future<void> _getArchive() async {
    String path = await _localPath;
    final archive = Archive();
    for (int i = 0; i < 56; i++) {
      String dataPath = '$path/new_id_$i.json';
      if (await File(dataPath).exists()) {
        var bytes = await File(dataPath).readAsBytes();
        final arc = ArchiveFile(dataPath, bytes.length, bytes);
        archive.addFile(arc);
      } else {
        // todo: add empty data
        continue;
      }
    }
    final ZipEncoder zipEncoder = ZipEncoder();
    final encodeArc = zipEncoder.encode(archive);
    if (encodeArc == null) throw Error();
    await File('$path/answer.zip').writeAsBytes(encodeArc);
  }

  Future<String> get archivePath async {
    String path = await _localPath;
    _getArchive();
    return '$path/answer.zip';
  }

  Future<File> writeLog(String log) async {
    final file = await _logTxt;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime now = DateTime.now();
    return file.writeAsString(dateFormat.format(now) + " " + log + "\n",
        mode: FileMode.append);
  }

  Future<File> saveAnswer(SingleResponse response) async {
    final file = await _localFileJson;
    return file.writeAsString(jsonEncode(response));
  }

  Future<File> saveNewResponse(NewResponse response) async {
    final file = await _localFileJson;
    return file.writeAsString(jsonEncode(response));
  }

  Future<List<Answer>> readLastTimeAnswers() async {
    try {
      final file = await _localFileJson;
      // Read the file
      final content = await file.readAsString();
      final decodedContent = json.decode(content);
      Map<String, dynamic> tmpMap = Map<String, dynamic>.from(decodedContent);
      List<Answer> answers = [];
      for (var tmp in tmpMap['answers']) {
        Answer answer = Answer(
            questionIndex: int.parse(tmp['questionIndex']),
            userAnswer: tmp['userAnswer'],
            userAnswerString: tmp['userAnswerString'],
            userSubAnswer: tmp['userSubAnswer'],
            questionType: tmp['questionType']);
        List<int> multiAnswer = [];
        List<String> multiAnswerString = [];

        if (tmp['multipleUserAnswer'] != null) {
          for (var i = 0; i < 8; i++) {
            multiAnswer.add(tmp['multipleUserAnswer'][i]);
            multiAnswerString.add(tmp['multipleUserAnswerString'][i]);
          }
          answer.setMultipleUserAnswer = multiAnswer;
          answer.setMultipleUserAnswerString = multiAnswerString;
        }

        // print(answer.toString());
        answers.add(answer);
      }

      return answers;
    } catch (e, stacktrace) {
      print("error $e");
      print("Stacktrace: " + stacktrace.toString());
      LocalStorage().writeLog("error at local storage: $e");
      throw Error();
    }
  }

  Future<NewResponse> readAnswers() async {
    try {
      final file = await _localFileJson;
      // Read the file
      final content = await file.readAsString();
      final decodedContent = json.decode(content);
      Map<String, dynamic> tmpMap = Map<String, dynamic>.from(decodedContent);
      var tmp = NewResponse.fromJson(tmpMap);
      return tmp;
    } catch (e) {
      print("error $e");
      throw Error();
    }
  }

  Future<dynamic> readFile() async {
    try {
      final file = await _localFileTxt;
      // Read the file
      final content = await file.readAsString();
      final decodedContent = jsonDecode(content);
      return decodedContent;
    } catch (e) {
      return 'There is some problem at reading data' + e.toString();
    }
  }

  Future<List<DateTime>> readWeekTime() async {
    List<DateTime> timeList = <DateTime>[];
    try {
      final file = await _localFileTxt;
      final content = await file.readAsString();
      List tmp = content.split('\n');
      for (var line in tmp) {
        DateTime time = DateTime.parse(line);
        timeList.add(time);
      }
    } catch (e) {
      print("error: $e");
    }
    return timeList;
  }

  Future<DateTime> readLastTime() async {
    DateTime time = DateTime.now();
    try {
      final file = await _localFileTxt;
      final content = await file.readAsString();
      List tmp = content.split('\n');
      print(tmp.last);
      if (tmp.length != 0) time = DateTime.parse(tmp.last);
    } catch (e) {
      print("error: $e");
    }

    LocalStorage()
        .writeLog("local storage, read last time, ${time.toString()}");
    return time;
  }

  static Future<int> getCurrentNotificationIDWhenInvalid() async {
    LocalStorage localStorage = LocalStorage(destination: "time_list");
    List<DateTime> timeList = await localStorage.readWeekTime();
    DateTime now = DateTime.now();
    if (now.isBefore(timeList[0])) return -1;

    int notificationID = 0;
    while (notificationID < 55) {
      DateTime last = timeList[notificationID];
      DateTime next = timeList[notificationID + 1];
      if (last.isBefore(now) && next.isAfter(now)) break;
      notificationID++;
    }
    return notificationID;
  }
}
