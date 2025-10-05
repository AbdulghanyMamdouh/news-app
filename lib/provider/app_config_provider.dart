import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    } else {
      appLanguage = newLanguage;
    }
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('language', appLanguage);
    notifyListeners();
  }
}
