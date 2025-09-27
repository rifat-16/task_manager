import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';

class AuthController{
  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    await sharedPreferences.setString(_userKey, jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    if(token != null){
      String? userJson = sharedPreferences.getString(_userKey);
      userModel = UserModel.fromJson(jsonDecode(userJson!));
      accessToken = token;
    }
  }

  static Future<bool> isUserAlreadyLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    return token != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}