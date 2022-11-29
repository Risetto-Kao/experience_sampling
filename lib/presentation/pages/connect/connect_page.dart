import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/presentation/constants/introduction.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class ConnectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(sendMailIntro,
            style: TextStyle(
                color: primaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        IconButton(
          iconSize: 50,
          icon: Icon(
            Icons.mail_outlined,
            color: primaryColor,
          ),
          onPressed: () async {
            String subjectID = DefaultConfig.getInstance().subjectID;
            final MailOptions mailOptions = MailOptions(
              body: problemEmailBody(subjectID),
              subject: problemEmailTitle(subjectID),
              recipients: [
                'test@gmail.com',
              ],
              isHTML: true,
              attachments: [await LocalStorage().logFilePath],
            );
            final MailerResponse response =
                await FlutterMailer.send(mailOptions);
            print(response);
          },
        ),
      ],
    ));
  }
}
