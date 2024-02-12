import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUserId = 'userId';
  static const _keyToken = 'token';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserId(String userId) async =>
      await _preferences.setString(_keyUserId, userId);

  static String? getUserId() => _preferences.getString(_keyUserId);

  static Future setToken(String token) async =>
      await _preferences.setString(_keyToken, token);

  static String? getToken() => _preferences.getString(_keyToken);
}
