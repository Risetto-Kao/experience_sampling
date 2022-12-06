import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/logic/intro/right_intro_controller.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/reuse_util/custom_text.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class RightIntroPage extends StatelessWidget {
  final controller = Get.put(RightIntroController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.rightIntroStatus.value) {
        case RightIntroStatus.GENERAL:
          return RightGeneral();
        case RightIntroStatus.PRINCIPLE:
          return RightPrinciple();
        case RightIntroStatus.PAY:
          return RightPay();
        default:
          return Container(
            child: Text("test"),
          );
      }
    });
  }
}

class RightGeneral extends StatelessWidget {
  final controller = Get.put(RightIntroController());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text(
            "作答原則",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () =>
              controller.setRightIntroStatus(RightIntroStatus.PRINCIPLE),
          trailing: Icon(Icons.navigate_next)),
      Divider(
        color: Colors.black,
      ),
      ListTile(
          title: Text(
            "報償",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () => controller.setRightIntroStatus(RightIntroStatus.PAY),
          trailing: Icon(Icons.navigate_next)),
      Divider(
        color: Colors.black,
      ),
    ]);
  }
}

class RightPrinciple extends StatelessWidget {
  final controller = Get.put(RightIntroController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () =>
                controller.setRightIntroStatus(RightIntroStatus.GENERAL),
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
          lineText("請在收到訊號後的「５分鐘內開始作答」，盡可能「立即作答」。"),
          lineText("開始作答後，請在「５分鐘內作答完畢」。"),
          lineText("請根據當下的想法作答"),
          lineText("在危險或不適合的情況下，請勿作答，例如：正在開車或過馬路。其他時候，請中斷您的活動，盡快開始作答。"),
          lineText("請盡可能「隨身攜帶手機」，並「保持網路連線狀態」，以利資料上傳。"),
          Text(
            lines("請仔細且誠實作答："),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          secondLineText("您作答的內容是會是「匿名」的，開發者、資料分析人員都不會知道您的任何資訊，請放心作答。"),
          secondLineText("為了確保可以得到真實的研究成果，請仔細且誠實作答，作答率越高越好。"),
          secondLineText("請不要隨機或隨意作答，這會誤導本研究對於人們心智運作的推論。"),
        ],
      ),
    );
  }
}

class RightPay extends StatelessWidget {
  final controller = Get.put(RightIntroController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () =>
                controller.setRightIntroStatus(RightIntroStatus.GENERAL),
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
          lineText("以下報償原則與參與者同意書之內容相同。"),
          lineText("您每天會收到 N 次訊號通知與題組，共持續 M 天，總共會收到 N * M 個題組。"),
          lineText("若完成的總題組數高於或等於 A 題，將以每填答一個題組可獲得新台幣 D 元的原則，依照答題總數，給予報償。"),
          lineText("若完成的總題組數高於或等於 B 題，將額外再獲得新台幣 E 元的報償。"),
          lineText("若完成的總題組數低於 C 題，將無法獲得此部分的任何報償。"),
          lineText("若您在參與此APP的受測過程中，因任何原因中途退出，仍會依照上述的報償原則，提供或不提供您參與費用。"),
          lineText("您可以隨時點進APP的作答紀錄頁面，查看自己已完成的題組數目。"),
        ],
      ),
    );
  }
}
