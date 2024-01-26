import 'package:union/models/volunteer.dart';
import 'package:union/network/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../cache.dart';

class AuthProvider with ChangeNotifier {
  String? errorMessage;
  VolunteerModel? volunteerModel;

  AuthProvider() {
    tryAutoLogin();
  }

  Future<void> login(Map<String, dynamic> data) async {
    Response? result = await AuthService.login(data);
    if (result!.statusCode == 200) {
      errorMessage = null;
      var data = result.data['data'];

      await Cache.saveToken(data['access_token']);
      await Cache.saveUserName(data['name']);
      volunteerModel = VolunteerModel  (
          name: data['name']);
    } else if (result.statusCode == 400 || result.statusCode == 401) {
      errorMessage = result.data['data']['message'];
    } else {
      errorMessage = 'Something was wrong!';
    }
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    String? name = await Cache.getUserName();


    if (name == null) {
      volunteerModel = null;
    } else {
      volunteerModel =
          VolunteerModel(name: name,);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await Cache.deleteToken();
    await Cache.deleteUserName();
    volunteerModel = null;
    notifyListeners();
  }
}
