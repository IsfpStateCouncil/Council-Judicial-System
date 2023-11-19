import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../functions/AfterBuild.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkConnection(context, "splash_screen");
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}

Future<int> user_exist() async {
  String? userName, password; //,id;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //id = prefs.getString("id");
  userName = prefs.getString("userName");
  password = prefs.getString("password");
  userName ??= "-1";
  password ??= "-1";
  if (userName == "-1" && password == "-1") {
    print("need login");
    return 0;
  } else {
    print("no  need login");
    return 1;
  }
}
