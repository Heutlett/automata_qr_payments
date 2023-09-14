import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStore {
  static const _keyLastUsername = 'last_username';
  static const _keyAccessToken = 'access_token';

  static Future<void> setUserLastUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastUsername, username);
  }

  static Future<void> resetLastUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastUsername, '');
  }

  static Future<String> getLastUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastUsername) ?? '';
  }

  static Future<void> setAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, accessToken);
  }

  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken) ?? '';
  }
}
