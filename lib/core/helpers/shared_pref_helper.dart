import 'dart:convert';
import 'package:rollshop/features/users/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesHelper {
  static Future<void> setUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    } else {
      return null;
    }
  }

  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  static Future<bool> getBoolValue(String key) async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getBool(key);
    return value ?? false;
  }

  static Future<int?> getIntValue(String key) async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getInt(key);
    return value;
  }

  static Future<String?> getStringValue(String key) async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getString(key);
    return value;
  }

  static Future<bool> setStringValue(String key, String value) async {
    final pref = await SharedPreferences.getInstance();
    final isSaved = await pref.setString(key, value);
    if (isSaved) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> setBoolValue(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    final isSaved = await pref.setBool(key, value);
    if (isSaved) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> setIntValue(String key, int value) async {
    final pref = await SharedPreferences.getInstance();
    final isSaved = await pref.setInt(key, value);
    if (isSaved) {
      return true;
    } else {
      return false;
    }
  }
}
