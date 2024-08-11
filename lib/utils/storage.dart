import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<void> saveDate(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
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
