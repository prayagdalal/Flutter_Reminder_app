import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrences {
  static Future<String> getSession(String key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  static Future<bool> setSession(String key, String value) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  static Future<bool> clearSession(String key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(key);
  }
}
