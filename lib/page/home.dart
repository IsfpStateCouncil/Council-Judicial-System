import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cutomwidget/bodyHomePage.dart';
import '../data/staticdata.dart';
import '../providerclasses.dart/controllerNotification.dart';
import '../providerclasses.dart/providerlanguage.dart';
import '../cutomwidget/NavBar.dart';
import 'package:badges/badges.dart' as badges;

import 'NotificationList.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = 'home_screen';

  @override
  State<Home> createState() => _BarChartAPIState();
}

class _BarChartAPIState extends State<Home> {
  bool loading = true;
  var fbm = FirebaseMessaging.instance;
  String? userName;
  String? password;
  int i = 0;
  @override
  void initState() {
    fbm.getToken().then((value) {
      print(value);
      FirebaseMessaging.onMessage.listen((event) {
        print(event.notification?.body);
        AwesomeDialog(
                title: "${event.notification?.title}",
                context: context,
                body: Text("${event.notification?.body}"),
                btnOkOnPress: () {})
            .show();
      });
    });

    super.initState();
  }

  void getDataNotification() async {
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

    ProviderNotificationModel provider =
        Provider.of<ProviderNotificationModel>(context);
    await provider.list_Data_Class(
        "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password",
        "dataNotificationModel");

    collections.forEach((key, values) async {
      String notificationEvent = "";
      for (int value in values) {
        notificationEvent += "&categories=$value";
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString("language", "ar");
      // languageProvider.language = "ar";
      userName = prefs.getString('userName');
      password = prefs.getString('password');
      print(
          "${StaticData.urlConnectionConst}${StaticData.getAllNotificationCategory}?userName=$userName&password=$password$notificationEvent");
      await provider.list_Data_Class(
          "${StaticData.urlConnectionConst}${StaticData.getAllNotificationCategory}?userName=$userName&password=$password$notificationEvent",
          "$key");
    });
  }

  @override
  Widget build(BuildContext context) {
    void check_user() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString("language", "ar");
      // languageProvider.language = "ar";
      userName = prefs.getString('userName');
      password = prefs.getString('password');

      print(userName);
      if (userName == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
      }
    }

    if (i < 2) {
      ProviderNotificationModel provider =
          Provider.of<ProviderNotificationModel>(context);
      // if (provider.dataNotificationModel.isEmpty) {
      provider.dataNotificationModel.isEmpty;
      check_user();
      getDataNotification();
      i++;
      // }
    }
    print(i);

    final languageProvider = Provider.of<LanguageProvider>(context);
    final providerNotificationModel =
        Provider.of<ProviderNotificationModel>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 183, 173, 201),
      drawer: NavBar(
        userName: userName,
        password: password,
        context: context,
        currentRoute: Home.routeName,
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 162, 46), //<-- SEE HERE
        title:
            Text("${languageProvider.getCurrentData('EgyptianStateCouncil')}"),
        centerTitle: true,
        elevation: 0,
        actions: [
          badges.Badge(
            badgeContent: Consumer<ProviderNotificationModel>(
                builder: (context, providerNotificationModel, child) {
              return Text(
                  "${providerNotificationModel.dataNotificationModel.length}");
            }),
            position: badges.BadgePosition.topEnd(top: 0, end: 0),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()),
                );
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: BodyHomePage(
        languageProvider: languageProvider,
        providerNotificationModel: providerNotificationModel,
        namePage: Home.routeName,
      ),
    );
  }
}
