import 'package:shared_preferences/shared_preferences.dart';

class ThemeToggle {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getBool({required String key}) {
    return sharedPreferences.getBool(key);
  }
}
