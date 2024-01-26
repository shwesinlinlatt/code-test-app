import 'package:shared_preferences/shared_preferences.dart';

const tokenName = 'TB-Tobacco-Secret-Token';
const userName = 'TB-Tobacco-User-Name';
const userCode = 'TB-Tobacco-User-Code';
const userTownship = 'TB-Tobacco-User-Township';
const app = 'TB-Tobacco-app';


class Cache {
  static saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenName, token);
  }
  static savePatientData(int id,String month, String data) async {
    final prefs = await SharedPreferences.getInstance();
    var key = '${app}patient$id$month';
    await prefs.setString(key, data);
  }
  static Future<String?> getPatientData(int id, String month) async {
    final prefs = await SharedPreferences.getInstance();
    var key = '${app}patient$id$month';
    String? data = prefs.getString(key);
    return data;
  }


  static saveUserName(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userName, username);
  }

  static saveUserCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userCode, code);
  }
  static saveUserTownship(String township) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userTownship, township);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? prefsToken = prefs.getString(tokenName);

    return prefsToken;
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String? prefsUserName = prefs.getString(userName);

    return prefsUserName;
  }

  static Future<String?> getUserCode() async {
    final prefs = await SharedPreferences.getInstance();
    String? prefsUserName = prefs.getString(userCode);

    return prefsUserName;
  }
  static Future<String?> getUserTownship() async {
    final prefs = await SharedPreferences.getInstance();
    String? prefsUserTownship = prefs.getString(userTownship);

    return prefsUserTownship;
  }

  static deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenName, '');
  }

  static deleteUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userName, '');
  }

  static deleteUserCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userCode, '');
  }
}
