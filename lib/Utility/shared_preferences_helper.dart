import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  removeAll() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }

}
class PrefUtils {
  static final String isFirstTime = "isFirstTime";



  static setBoolValue(String key, bool defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, defaultValue);
  }

  static void saveInitialScreenState(bool value) async {
    PrefUtils.setBoolValue(PrefUtils.isFirstTime, value);
  }

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key)
    ;
  }
}