import 'package:flutter/material.dart';

import 'status_icon.dart';


class ShowDailyStatus extends StatelessWidget {
  final String date;
  final List<String> dailyStatus;
  const ShowDailyStatus({Key? key,required this.date,required this.dailyStatus})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(10),
            child: Text(date, style: TextStyle(fontSize: 18))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateDailyStatus(dailyStatus),
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}

List<Widget> generateDailyStatus(List<String> dailyStatus) {
  List<Widget> dailyStatusWidgets =
      dailyStatus.map((e) => generateStatusIcon(e)).toList();
  return dailyStatusWidgets;
}
