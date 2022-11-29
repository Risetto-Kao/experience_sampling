import 'package:flutter/material.dart';

import 'status_icon.dart';

Container generateStatusItem(String status, int? statusCount) {
  int _count;
  if (statusCount == null){
    _count = 0;
  } else {
    _count = statusCount;
  }

  String statusText = '';
  Color? statusColor;
  switch (status) {
    case 'not_yet':
      statusText = '尚未開始';
      statusColor = Colors.grey;
      break;
    case 'pass':
      statusText = '未填答';
            statusColor = Colors.redAccent[200];
      break;
    case 'uncomplete':
      statusText = '填答不完整';
            statusColor = Colors.purpleAccent[200];
      break;
    case 'done':
      statusText = '已完成';
            statusColor = Colors.green[400];
      break;
    default:
      statusText = '預設值';
      statusColor = Colors.black;
      
      break;
  }

  return Container(
    padding: EdgeInsets.all(5),
    child: Row(
      children: [
        generateStatusIcon(status),
        Text(
          '$statusText: $_count',
          style: TextStyle(color: statusColor),
        ),
      ],
    ),
  );
}
