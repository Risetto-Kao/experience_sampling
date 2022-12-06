import 'package:experience_sampling/presentation/constants/introduction.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/presentation/reuse_util/custom_text.dart';
import 'package:experience_sampling/presentation/reuse_util/utility_launcher.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class QuitPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '退出研究',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            lineText(
              "中途退出研究操作說明：若您欲中途退出研究，請依序按照下列步驟進行，中途退出此研究之後，即無法再重新參與",
            ),
            numberLineText("請確保手機的網際網路為開啟狀態，以利上傳已作答的資料", 1),
            numberLineText("請點選下方「中途退出事前通知」選項，來信通知您欲申請退出。", 2),
            numberLineText(
                "請等候本研究團隊回信之後，您即可透過刪除此APP，完成中途退出本研究。本團隊也會同時與您確認您的費用報償", 3),
            numberLineText("在等候本研究團隊回信的期間，您可以從手機的「系統」，關閉此APP的通知，即不會再收到提醒訊號", 4),
            MaterialButton(
              color: primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '中途退出事前通知',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                String subjectID = DefaultConfig.getInstance().subjectID;
                UtilityLauncher.openEmail(
                    toEmail: experimenterEmails,
                    subject: quitEmailTitle(subjectID),
                    body: quitEmailBody(subjectID));
              },
            ),
          ],
        ),
      ),
    );
  }
}
