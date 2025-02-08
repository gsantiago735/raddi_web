import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static const String _tokenKey = "tokenKey";
  static const String _userIdKey = "userIdKey";
  static const String _userTypeKey = "userTypeKey";
  static const String _emailKey = "emailKey";
  static const String _passwordKey = "passwordKey";
  // static const String _onboardingSeenKey = "onboardingSeenKey";

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Writte

  static Future<void> setSession({
    required int? userType,
    required int? id,
    required String? token,
  }) async {
    if (userType == null) {
      throw Exception("User Type is null");
    }
    if ((token ?? "").isEmpty) {
      throw Exception("token is null");
    }
    if (id == null) {
      throw Exception("User id is null");
    }

    await prefs.setString(_tokenKey, token!);
    await prefs.setInt(_userIdKey, id);
    await prefs.setInt(_userTypeKey, userType);
  }

  static Future<void> setCredentials({
    required String? email,
    required String? password,
  }) async {
    if ((email ?? "").isEmpty) {
      throw Exception("Email is null");
    }
    if ((password ?? "").isEmpty) {
      throw Exception("Password is null");
    }

    await prefs.setString(_emailKey, email!);
    await prefs.setString(_passwordKey, password!);
  }

  // Get
  static String? getEmail() => prefs.getString(_emailKey);

  static String? getPassword() => prefs.getString(_passwordKey);

  static String? getToken() => prefs.getString(_tokenKey);
/*
  static int? getUserId() {
    final id = prefs.getInt(_userIdKey);

    try {
      if (id == null) {
        throw Exception("-------EL ID DEL USUARIO ES NULO-------");
      }
    } catch (e) {
      log(e.toString());
    }

    log(id.toString());
    return id;
  }
   */

  static int? getUserType() => prefs.getInt(_userTypeKey);

  // Delete

  /*
  static Future<void> deleteSession() async {
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userTypeKey);
  }
 */

  static Future<void> deleteCredentials() async {
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }

  /*
  static Future<void> clear() async {
    await prefs.clear();
  }
  */
}
