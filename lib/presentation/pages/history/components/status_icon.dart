import 'package:flutter/material.dart';

Icon generateStatusIcon(String status) {
  final double iconSize = 30;
  if (status == 'done')
    return Icon(
      Icons.check_circle,
      color: Colors.green[400],
      size: iconSize,
    );
  if (status == 'uncomplete')
    return Icon(
      Icons.change_history,
      color: Colors.purpleAccent[200],
      size: iconSize,
    );
  if (status == 'not_yet')
    return Icon(
      Icons.pending,
      color: Colors.grey,
      size: iconSize,
    );
  if (status == 'pass')
    return Icon(
      Icons.highlight_off,
      color: Colors.redAccent[200],
      size: iconSize,
    );
  return Icon(
    Icons.help_outline,
    size: iconSize,
  );
}