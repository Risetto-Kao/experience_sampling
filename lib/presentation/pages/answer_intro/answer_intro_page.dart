import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/intro/answer_intro.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/reuse_util/custom_text.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class AnswerIntroPage extends StatelessWidget {
  final controller = Get.put(AnswerIntroController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.answerIntroStatus.value) {
        case AnswerIntroStatus.GENERAL:
          return AnswerGeneral();
        case AnswerIntroStatus.DEFINITION:
          return AnswerDefinition();
        case AnswerIntroStatus.AWARE:
          return AnswerAware();
        case AnswerIntroStatus.ACTION:
          return AnswerAction();
        default:
          return Container(
            child: Text("Error"),
          );
      }
    });
  }
}

class AnswerGeneral extends StatelessWidget {
  final controller = Get.put(AnswerIntroController());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text(
            "思緒漫遊的定義與例子",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () =>
              controller.setAnswerIntroStatus(AnswerIntroStatus.DEFINITION),
          trailing: Icon(Icons.navigate_next)),
      Divider(
        color: Colors.black,
      ),
      ListTile(
          title: Text(
            "思緒漫遊的發覺與否",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () => controller.setAnswerIntroStatus(AnswerIntroStatus.AWARE),
          trailing: Icon(Icons.navigate_next)),
      Divider(
        color: Colors.black,
      ),
      ListTile(
          title: Text(
            "正在進行的活動",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () =>
              controller.setAnswerIntroStatus(AnswerIntroStatus.ACTION),
          trailing: Icon(Icons.navigate_next)),
      Divider(
        color: Colors.black,
      ),
    ]);
  }
}

class AnswerDefinition extends StatelessWidget {
  final controller = Get.put(AnswerIntroController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () =>
                controller.setAnswerIntroStatus(AnswerIntroStatus.GENERAL),
            title: Row(
              children: [
                Icon(Icons.navigate_before),
                SizedBox(width: 10),
                Text(
                  "返回",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ],
            ),
          ),
          Divider(),
          Text(
            lines("思緒漫遊的定義："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          nolineText("若您的正在進行一些活動，但是您的思緒與這些活動並不相關，就是思緒漫遊"),
          Text(
            lines("思緒漫遊的例子："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          pointText(1,
              "想像您正在閱讀一本書，當接收到此ＡＰＰ訊號時，您發現即使自己正盯著書本，但想的是朋友昨天告訴您的事情。這樣就算為正在「思緒漫遊」。"),
          pointText(2,
              "想像您正與朋友一起吃午餐，並談論這周末的規劃，當接收到此ＡＰＰ訊號時，您發現即使自己正附和著朋友，想的卻是稍早在課堂中發生的事情。這樣就算為正在「思緒漫遊」。"),
          Text(
            lines("非思緒漫遊的例子："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          pointText(1,
              "您正在家裡尋找一個東西，當接收到此ＡＰＰ訊號時，您正在思考下一個要找的地方是哪裡。這樣就「不」算為思緒漫遊，因為您的思緒與正進行的活動有關。"),
          pointText(2,
              "您正在提款機前面領錢，當接收到此ＡＰＰ訊號時，您正在思考須要領多少錢。這樣就「不」算為思緒漫遊，因為您的思緒與正進行的活動有關。"),
          Text(
            lines("其他特例："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          nolineText(
              "有些時候您可能沒有在做任何須要思考的事情，像是搭乘公車，或坐在沙發上休息，而沒有進行任何其他活動。即使您沒有在做任何事情，只要您的思緒與當下的情境不相關，這樣就算為正在「思緒漫遊」。"),
        ],
      ),
    );
  }
}

class AnswerAware extends StatelessWidget {
  final controller = Get.put(AnswerIntroController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () =>
                controller.setAnswerIntroStatus(AnswerIntroStatus.GENERAL),
            title: Row(
              children: [
                Icon(Icons.navigate_before),
                SizedBox(width: 10),
                Text(
                  "返回",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ],
            ),
          ),
          Divider(),
          lineText("如果您正在思緒漫遊，我們會進一步詢問您是否在接受到訊號的前一刻，您就已經發覺自己正在思緒漫遊。涵義分別如下："),
          Text(
            points(1, "已經發覺自己正在思緒漫遊："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          nolineText("在接收到訊號的前一刻，您正在思緒漫遊，而且在此期間，您就已經發現自己正在思緒漫遊，不是訊號出現後被問了才發現。"),
          Text(
            points(2, "沒有發覺自己正在思緒漫遊："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          nolineText(
              "在接收到訊號的前一刻，您正在思緒漫遊，但是您可能沉浸在這些思緒裡，並沒有發覺自己正在思緒漫遊，直到訊號出現後被問了才發現。"),
        ],
      ),
    );
  }
}

class AnswerAction extends StatelessWidget {
  final controller = Get.put(AnswerIntroController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () =>
                controller.setAnswerIntroStatus(AnswerIntroStatus.GENERAL),
            title: Row(
              children: [
                Icon(Icons.navigate_before),
                SizedBox(width: 10),
                Text(
                  "返回",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ],
            ),
          ),
          Divider(),
          Text(
            lines("主要活動與次要活動的判斷："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          nolineText(
              "如果在收到訊號的前一刻，您正同時進行一個以上的活動，如：一邊吃飯，一邊聽朋友說話，又一邊滑手機，那麼請從中選擇兩個主要的活動，再進一步從中判斷主要與次要活動。請將當下佔據您的心思最大部分的活動視為主要活動。"),
          Text(
            lines("活動類別的判斷："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          nolineText(
              "有一些活動可以同時被歸類在兩種以上的類別，如：健身環活動，可以從「體能鍛鍊」與「遊戲」之間擇一。請依據您從事此活動的主要目的進行判斷。"),
        ],
      ),
    );
  }
}
