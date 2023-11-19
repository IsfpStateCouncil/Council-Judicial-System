import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../functions/listDyanmicconverter.dart';
import '../data/staticdata.dart';
import '../page/ErrorPage.dart';
import '../page/home.dart';

class ProviderUserData extends ChangeNotifier {
  String? userName;
  String? password;
  void setterUser(String userName, String password) {
    this.userName = userName;
    this.password = password;
  }

  Future<dynamic> login(BuildContext context, String controllerUsername,
      String controllerPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final Response response = await post(
        Uri.parse("${StaticData.loginConst}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "userName": controllerUsername,
          "password": controllerPassword
        }),
      );
      print(response.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['success'] == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ErrorPage()),
          );
        } else {
          List<String> componentsList =
              convertDynamicListToStringList(data["components"]);
          List<String> modulesList =
              convertDynamicListToStringList(data["modules"]);
          prefs.setStringList("components", componentsList);
          prefs.setStringList("modules", modulesList);
          prefs.setString("userName", controllerUsername);
          prefs.setString("password", controllerPassword);
          prefs.setString("userType", data["userType"]);
          print(prefs.getString("userType"));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false);
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ErrorPage()),
        );
      }
    } catch (e) {
      print(e.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
  }
}
