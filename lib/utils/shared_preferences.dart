import 'dart:convert';

import 'package:auth_reg/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static const String kUserName = 'user_name';
  static const String kUserEmail = 'user_email';
  static const String kSessionToken = 'session_token';
  static const String kJsonDb = 'json_db';

  factory SharedPrefsManager() => _instance;

  static final SharedPrefsManager _instance = SharedPrefsManager._internal();

  SharedPrefsManager._internal();

  SharedPreferencesWithCache? _prefs;

  Future<void> init() async {
    if (_prefs != null) {
      return;
    }
    _prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
            allowList: <String>{
          kJsonDb,
          kUserEmail,
          kUserName,
          kSessionToken
        }));
  }

  String get getUserName => _prefs?.getString(kUserName) ?? '';
  String get getUserEmail => _prefs?.getString(kUserEmail) ?? '';
  String get getSessionToken => _prefs?.getString(kSessionToken) ?? '';
  List<User> get getUsersFromDb {
    final String jsonString = _prefs?.getString(kJsonDb) ?? '';
    if (jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => User.fromJson(e)).toList();
  }

  Future<void> setUserName(String value) async =>
      await _prefs?.setString(kUserName, value);
  Future<void> setUserEmail(String value) async =>
      await _prefs?.setString(kUserEmail, value);
  Future<void> setUsersToDb(List<User> users) async {
    final jsonList = users.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs?.setString(kJsonDb, jsonString);
  }

  Future<void> setSessionToken(String value) async =>
      await _prefs?.setString(kSessionToken, value);

  Future<void> clearSessionToken() async {
    await _prefs?.remove(kSessionToken);
  }
}
