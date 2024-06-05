import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final SharedPreferences _prefs;
  SharedPref(this._prefs);

  void login() {
    _prefs.setBool("isLoggedIn", true);
  }

  void logout() {
    _prefs.setBool('isLoggedIn', false);
  }

  bool isLoggedIn() {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  void setNotificationToken(String token) {
    _prefs.setString('notificationToken', token);
  }

  String getNotificationToken() {
    return _prefs.getString('notificationToken') ?? '';
  }
}
