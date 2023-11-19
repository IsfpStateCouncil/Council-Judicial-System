  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/staticdata.dart';
import '../providerclasses.dart/controllerNotification.dart';

Future<void> getDataNotification(BuildContext context) async {
    Map<String, List> collections = {
      "dataNotificationModelRequest": [16, 17, 18, 19, 20],
      "dataNotificationModelSend": [],
      "dataNotificationModelSession": [
        1,
        2,
        3,
        8,
        9,
        10,
        11,
        12,
        13,
        15,
        21,
        22
      ],
      "dataNotificationModeldSuit": [25, 26],
      "dataNotificationModelFine": [14],
      "dataNotificationModelTempSession": [4, 5]
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString("language", "ar");
    // languageProvider.language = "ar";
    String? userName = prefs.getString('userName');
    String? password = prefs.getString('password');
     ProviderNotificationModel provider =
        Provider.of<ProviderNotificationModel>(context, listen: false);
    await provider.list_Data_Class(
        "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password",
        "dataNotificationModel");

    collections.forEach((key, values) async {
      String notificationEvent = "";
      for (int value in values) {
        notificationEvent += "&categories=$value";
      }

      print(
          "${StaticData.urlConnectionConst}${StaticData.getAllNotificationCategory}?userName=$userName&password=$password$notificationEvent");
      await provider.list_Data_Class(
          "${StaticData.urlConnectionConst}${StaticData.getAllNotificationCategory}?userName=$userName&password=$password$notificationEvent",
          "$key");
    });
  }