import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Storage {
  Future<void> saveDate(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<void> saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user', user.toJson());
  }

  Future<UserModel?> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userJson = pref.getString('user');
    return userJson != null ? UserModel.fromJson(userJson) : null;
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
