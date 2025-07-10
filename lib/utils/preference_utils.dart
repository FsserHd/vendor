

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils{

  static saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
  }

  static saveZoneId(String zoneId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("zoneId", zoneId);
  }

  static saveVendorType(String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("type", type);
  }

  static Future<String?> getVendorType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("type");
  }


  static Future<String?> getZoneId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("zoneId");
  }


  static saveUserToken(String userToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token",userToken);
  }

  static Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }

  static saveCurrentPage(String page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("page", page);
  }


  static Future<String?> getCurrentPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("page");
  }

}