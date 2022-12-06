import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToSharedPreferences(String key, dynamic value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (value is int)
    sharedPreferences.setInt(key, value);
  else if (value is String)
    sharedPreferences.setString(key, value);  
  else if (value is bool)
    sharedPreferences.setBool(key, value);
  else if (value is List) {
    List<String> newValue = [];
    value.forEach((e) => newValue.add(e.toString()));
    sharedPreferences.setStringList(key, newValue);
  } else if (value is double)
    sharedPreferences.setDouble(key, value);
  else
    sharedPreferences.setString(key, jsonEncode(value));
}

// if get null
Future<dynamic> readFromSharedPreferences(String key, Type type) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (type is int) return sharedPreferences.getInt(key) ?? -404;
  if (type is String) return sharedPreferences.getString(key) ?? 'get null';
  if (type is bool) return sharedPreferences.getBool(key) ?? false;
  if (type is List) return sharedPreferences.getStringList(key) ?? ['get null'];
  if (type is double) return sharedPreferences.getDouble(key) ?? -404;
  return sharedPreferences.getString(key) ?? 'get null';
}

