import 'package:shared_preferences/shared_preferences.dart';

class Shredprefdata {
  late SharedPreferences prefs;
  Future<void> saveUserData(
      String userId, String userName, String password) async {
    await SharedPreferences.getInstance();

    prefs.setString('userId', userId);
    prefs.setString('userName', userName);
    prefs.setString('password', password);
  }
}
