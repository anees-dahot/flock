import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Storage {
  Future<void> saveDate(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<void> saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(
        'user', user.toJson()); 
  }

  Future<void> getUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString('user');
  }

  Future<void> getData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString(key);
  }

  Future<void> deleteData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}
