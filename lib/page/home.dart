import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:council_of_state/functions/AfterBuild.dart';
import 'package:council_of_state/page/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cutomwidget/bodyHomePage.dart';
import '../data/staticdata.dart';
import '../functions/arabicTime.dart';
import '../functions/updatenotification.dart';
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

  static int loopingFlag = 0;
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

  void check_user() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", "ar");
    userName = prefs.getString('userName');
    password = prefs.getString('password');

    print(userName);
    if (userName == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  Future<void> changeLanguage() async {}
  @override
  Widget build(BuildContext context) {
    // arabicTime();
    //   Locale myLocale = Localizations.localeOf(context);
    //   print(myLocale.languageCode);
    ProviderNotificationModel provider =
        Provider.of<ProviderNotificationModel>(context);
    if (provider.dataNotificationModel.isEmpty) {
      if (loopingFlag < 2) {
        checkConnection(context, Home.routeName);
        provider.dataNotificationModel.isEmpty;
        check_user();
        getDataNotification(context);
        loopingFlag = loopingFlag + 1;
      }
    }

    final languageProvider = Provider.of<LanguageProvider>(context);
    final providerNotificationModel =
        Provider.of<ProviderNotificationModel>(context);

    return Scaffold(
      backgroundColor: StaticData.backgroundColors,
      endDrawer: NavBar(
        context: context,
        currentRoute: Home.routeName,
      ),
      appBar: AppBar(
        backgroundColor: StaticData.appBarColor, //<-- SEE HERE
        title: Text(
          "${languageProvider.getCurrentData('EgyptianStateCouncil')}",
          style: TextStyle(
            fontFamily: StaticData.fontFamily,
            // Add other text styles as needed
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: badges.Badge(
          badgeContent: Consumer<ProviderNotificationModel>(
              builder: (context, providerNotificationModel, child) {
            return Text(
                "${providerNotificationModel.dataNotificationModel.length}");
          }),
          position: badges.BadgePosition.topEnd(top: 5, end: 5),
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              color: StaticData.button,
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
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          },
        ),
        actions: [],
      ),
      body: BodyHomePage(
        languageProvider: languageProvider,
        providerNotificationModel: providerNotificationModel,
        namePage: Home.routeName,
        onRefresh: () async {
          await getDataNotification(context);
        },
      ),
    );
  }
}
