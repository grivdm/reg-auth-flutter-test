import 'dart:developer';

import 'package:auth_reg/models/user.dart';
import 'package:auth_reg/utils/encription.dart';
import 'package:auth_reg/utils/shared_preferences.dart';
import 'package:auth_reg/utils/token.dart';

class AuthManager {
  static User? getUser(String email) {
    final List<User> users = SharedPrefsManager().getUsersFromDb;
    try {
      return users.firstWhere((element) => element.email == email);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    final User? user = getUser(email);
    if (user == null) {
      return false;
    }
    final _hashPassword = Encription.hashPassword(password);
    if (user.hashPassword == _hashPassword) {
      await SharedPrefsManager().setUserName(user.name);
      await SharedPrefsManager().setUserEmail(user.email);
      await SharedPrefsManager().setSessionToken(TokenManager.generateToken());
      return true;
    }
    return false;
  }

  static Future<void> signUp(String email, String password, String name) async {
    final User? user = getUser(email);
    if (user != null) {
      throw Exception('User already exists');
    }
    final _hashPassword = Encription.hashPassword(password);
    final newUser = User(email: email, hashPassword: _hashPassword, name: name);
    final List<User> users = SharedPrefsManager().getUsersFromDb;
    users.add(newUser);
    await SharedPrefsManager().setUsersToDb(users);
    log('User ${newUser.name} SignedUp');
  }

  static Future<void> signOut() async {
    await SharedPrefsManager().setUserName('');
    await SharedPrefsManager().setUserEmail('');
    await SharedPrefsManager().clearSessionToken();
  }
}
