import 'package:council_of_state/page/ConnectionError.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../page/home.dart';
import '../page/login.dart';
import '../providerclasses.dart/providerlanguage.dart';
import '../routes.dart';
import 'AwesomeConnection.dart';

void checkConnection(BuildContext context, String pageName) {
  SchedulerBinding.instance.addPostFrameCallback((_) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return ConnectionError();
      }), (Route<dynamic> route) => false);
    } else {
      String pageExist = "splash_screen";
      if (pageExist == pageName) {
        bool isExist = await user_exist();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return isExist ? Home() : Login();
        }));
      }
      print("continue");
    }
  });
}

void continueConnection(
    BuildContext context, LanguageProvider languageProvider) {
  SchedulerBinding.instance.addPostFrameCallback((_) async {
    bool isExist = await user_exist();
    if (await InternetConnectionChecker().hasConnection) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return isExist ? Home() : Login();
      }));
    } else {
      createAwesome(context, languageProvider);
    }
  });
}
