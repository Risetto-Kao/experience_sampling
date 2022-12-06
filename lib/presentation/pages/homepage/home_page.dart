import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/general/config_controller.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/constants/introduction.dart';
import 'package:experience_sampling/presentation/reuse_util/custom_text.dart';
import 'package:experience_sampling/presentation/router/route_config.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:get/get.dart';

class HomeSection extends StatelessWidget {
  final ConfigController configController = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Image.asset(ImagePath.APP_ICON),
            margin: const EdgeInsets.only(top: 30, bottom: 10),
          ),
          Obx(() {
            switch (configController.status.value) {
              case ExpStatus.NOT_STARTED:
                return NotStartedIntro();
              case ExpStatus.RUNNING:
                return NotStartedIntro();
              case ExpStatus.END:
                return EndIntro();
              default:
                return NotStartedIntro();
            }
          }),
        ],
      ),
    );
  }
}

class EndIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lineText("恭喜您，研究已結束，非常感謝您參與本研究。"),
          lineText(
              "請點選下方的按鈕，寄信通知研究團隊已結束研究，煩請等候本研究團隊來信給您，確保已收到所有的作答資料後，再行刪除此APP。"),
          TextButton(
            child: Text("點此進入寄信頁面"),
            onPressed: () async {
              String subjectID = DefaultConfig.getInstance().subjectID;
              final MailOptions mailOptions = MailOptions(
                body: endEmailBody(subjectID),
                subject: endEmailTitle(subjectID),
                recipients: [
                  'test@gmail.com',
                ],
                isHTML: true,

                // todo:
                attachments: [await LocalStorage().archivePath],
              );
              final MailerResponse response =
                  await FlutterMailer.send(mailOptions);
              print(response);
            },
          ),
          lineText("本研究團隊會同時在信件中確認您的費用報償與給付方式。"),
          lineText("再次感謝您對本研究的支持與協助，祝您一切順心。"),
        ],
      ),
    );
  }
}

class RunningIntro extends StatelessWidget {
  const RunningIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(50),
      child: Text(
        "建議維持網路開啟，以免資料傳遞無法成功",
        style: TextStyle(fontSize: 18, color: primaryColor, height: 1.7),
      ),
    );
  }
}

class NotStartedIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "親愛的參與者您好：",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            lineText("您每天會收到 N 個題組，請留意訊號通知，收到後請盡量立刻作答。"),
            lineText("請在 K 分鐘內開始作答，並在 L 分鐘內作答完畢。"),
            lineText("請盡量隨身攜帶手機，並請維持網路開啟。"),
            lineText("為確保得到真實的心理學研究成果，請您務必仔細且誠實作答，且作答率越高越好。"),
            lineText("祝您有個美好的一天。"),
          ],
        ),
        IconButton(
          iconSize: 50,
          icon: Icon(
            Icons.settings_outlined,
            color: primaryColor,
          ),
          onPressed: () => Get.toNamed(RouteConfig.setting),
        ),
      ],
    );
  }
}
