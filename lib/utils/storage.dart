import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Storage {
  Future<void> saveDate(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<void> saveUserData(UserModel user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user', json.encode(user.toJson()));
}

Future<UserModel?> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userData = prefs.getString('user');

  if (userData != null) {
    return UserModel.fromJson(json.decode(userData));
  }
  return null;
}

  Future<String?> getData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<void> deleteData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}
