import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowInformation {
  static void customSnackbar({required String title, required String message}) =>
      Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);

  void canNotModify() => customSnackbar(title: "系統訊息", message: "無法更改此項目");

  static void customDialog({required String title, required Widget content}) =>
      Get.defaultDialog(title: title, content: content);
}
