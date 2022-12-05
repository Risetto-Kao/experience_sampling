import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/pages/test_q/test_q_page.dart';

String lines(String str) {
  String line = "";
  int lineCnt = ((str.length) / 15).floor();
  int lineRest = (str.length) % 15;
  if (str.length == 15) return "■\t" + str + "\n";
  if (lineCnt == 0) return "■\t" + str + "\t" * 4 * (15 - str.length) + "\n";

  for (int i = 0; i <= lineCnt; i++) {
    if (i == 0) {
      line += "■\t" + str.substring(i * 15, (i + 1) * 15) + "\n";
    } else if (i == lineCnt) {
      if (lineRest != 0) line += "\t\t\t\t\t" + str.substring(i * 15) + "\n";
    } else {
      line += "\t\t\t\t\t" + str.substring(i * 15, (i + 1) * 15) + "\n";
    }
  }
  return line;
}

Text lineText(String line) {
  return Text(
    lines(line),
    style: TextStyle(fontSize: 18),
  );
}

String numberLines(String str, int index) {
  String line = "";
  int lineCnt = ((str.length) / 15).floor();
  int lineRest = (str.length) % 15;
  if (str.length == 15) return "$index.\t" + str + "\n";
  if (lineCnt == 0)
    return "$index.\t" + str + "\t" * 4 * (15 - str.length) + "\n";

  for (int i = 0; i <= lineCnt; i++) {
    if (i == 0) {
      line += "$index.\t" + str.substring(i * 15, (i + 1) * 15) + "\n";
    } else if (i == lineCnt) {
      if (lineRest != 0) line += "\t\t\t\t\t" + str.substring(i * 15) + "\n";
    } else {
      line += "\t\t\t\t\t" + str.substring(i * 15, (i + 1) * 15) + "\n";
    }
  }
  return line;
}

Text numberLineText(String line, int index) {
  return Text(
    numberLines(line, index),
    style: TextStyle(fontSize: 18),
  );
}

String nolines(String str) {
  String line = "";
  int lineCnt = ((str.length) / 15).floor();
  int lineRest = (str.length) % 15;
  if (str.length == 15) return "\t\t\t\t\t" + str + "\n";
  if (lineCnt == 0)
    return "\t\t\t\t\t" + str + "\t" * 4 * (15 - str.length) + "\n";

  for (int i = 0; i <= lineCnt; i++) {
    if (i == 0) {
      line += "\t\t\t\t\t" + str.substring(i * 15, (i + 1) * 15) + "\n";
    } else if (i == lineCnt) {
      if (lineRest != 0) line += "\t\t\t\t\t" + str.substring(i * 15) + "\n";
    } else {
      line += "\t\t\t\t\t" + str.substring(i * 15, (i + 1) * 15) + "\n";
    }
  }
  return line;
}

Text nolineText(String line) {
  return Text(
    nolines(line),
    style: TextStyle(fontSize: 18),
  );
}

String secondLines(String str) {
  final int c = 15;
  String line = "";
  int lineCnt = ((str.length) / c).floor();
  int lineRest = (str.length) % c;
  if (str.length == c) return "\t\t\t\t\t\t-\t" + str;
  if (lineCnt == 0)
    return "\t\t\t\t\t\t-\t" + str + "\t" * 4 * (c - str.length);

  for (int i = 0; i <= lineCnt; i++) {
    if (i == 0) {
      line += "\t\t\t\t\t\t-\t" + str.substring(i * c, (i + 1) * c) + "\n";
    } else if (i == lineCnt) {
      if (lineRest != 0)
        line += "\t\t\t\t\t\t\t\t" + str.substring(i * c) + "\n";
    } else {
      line += "\t\t\t\t\t\t\t\t" + str.substring(i * c, (i + 1) * c) + "\n";
    }
  }
  return line;
}

Text secondLineText(String line) {
  return Text(
    secondLines(line),
    style: TextStyle(fontSize: 17),
  );
}

String points(int index, String str) {
  String line = "";
  int lineCnt = ((str.length) / 15).floor();
  int lineRest = (str.length) % 15;
  if (str.length == 15) return "$index. " + str;
  if (lineCnt == 0) return "$index. " + str + " " * 4 * (15 - str.length);

  for (int i = 0; i <= lineCnt; i++) {
    if (i == 0) {
      line += "$index. " + str.substring(i * 15, (i + 1) * 15) + "\n";
    } else if (i == lineCnt) {
      if (lineRest != 0) line += "\t\t\t\t" + str.substring(i * 15) + "\n";
    } else {
      line += "\t\t\t\t" + str.substring(i * 15, (i + 1) * 15) + "\n";
    }
  }
  return line;
}

Text pointText(int index, String point) {
  return Text(
    points(index, point),
    style: TextStyle(fontSize: 18),
  );
}
