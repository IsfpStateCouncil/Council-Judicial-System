import 'package:council_of_state/data/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../page/DataTableSearch.dart';
import '../page/NotificationAllPage.dart';
import '../page/Splashscreen.dart';
import '../page/home.dart';

import '../providerclasses.dart/controllerNotification.dart';
import '../providerclasses.dart/provicerdatatablesearch.dart';
import '../providerclasses.dart/providerNotificationAll.dart';
import '../providerclasses.dart/providerlanguage.dart';

class NavBar extends StatefulWidget {
  final String? currentRoute;
  final BuildContext context;

  // Constructor
  NavBar({Key? key, required this.context, required this.currentRoute})
      : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String? userName;
  String? password;
  String? arabicName;
  static const home = 'home_screen';
  static const datatableSearch = 'parameter_search';
  static const lisrNotification = 'notification_list_screen';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName');
    password = prefs.getString('password');
    arabicName = prefs.getString('arabicFullName');
    if (mounted) {
      // Ensure the widget is still in the tree before calling setState
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(this.context, listen: true);

    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 50),
          Image.asset(
            'assets/images/logo.PNG',
            width: 70, // Set your desired width
            height: 70, // Set your desired height
          ),
          Text(
            "$arabicName",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: StaticData.font,
              fontFamily: StaticData.fontFamily,
            ),
            //textAlign: TextAlign.right,
          ),
          const Divider(thickness: 2),
          Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              trailing: const Icon(
                Icons.home, color: StaticData.button, // Set your desired color
                size: 32,
              ),
              title: Text(
                languageProvider.getCurrentData('mainPage'),
                style: TextStyle(
                    fontSize: 20,
                    color: StaticData.font,
                    fontFamily: StaticData.fontFamily),
                //textAlign: TextAlign.right,
              ),
              //leading: const Icon(Icons.home),
              onTap: () {
                BarChartAPIState.loopingFlag = 0;
                if (widget.currentRoute != home) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          const Divider(thickness: 2),
          Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              trailing: const Icon(
                Icons.notifications,
                color: StaticData.button, // Set your desired color
                size: 32,
              ),
              title: Text(
                languageProvider.getCurrentData('allNotification'),
                style: TextStyle(
                    fontSize: 20,
                    color: StaticData.font,
                    fontFamily: StaticData.fontFamily),
                //  textAlign: TextAlign.right,
              ),
              //leading: const Icon(Icons.home),
              onTap: () {
                BarChartAPIState.loopingFlag = 0;
                //if (widget.currentRoute != lisrNotification) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationAllPage()),
                );
                //} else {
                //  Navigator.of(context).pop();
                // }
              },
            ),
          ),
          const Divider(thickness: 2),
          Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              trailing: const Icon(
                Icons.exit_to_app,
                color: StaticData.button, // Set your desired color
                size: 32,
              ),
              title: Text(
                languageProvider.getCurrentData('logout'),
                style: TextStyle(
                    fontSize: 20,
                    color: StaticData.font,
                    fontFamily: StaticData.fontFamily),
                //  textAlign: TextAlign.right,
              ),
              onTap: () async {
                BarChartAPIState.loopingFlag = 0;
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.clear();
                prefs.remove('userToken');
                prefs.remove('userId');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                );
                final providerNotificationAllModel =
                    Provider.of<ProviderNotificationAllModel>(this.context,
                        listen: false);
                final providerNotificationModel =
                    Provider.of<ProviderNotificationModel>(this.context,
                        listen: false);
                final providerDataTableSearch =
                    Provider.of<ProviderDataTableSearch>(this.context,
                        listen: false);
                providerNotificationAllModel.deleteTempData();
                providerNotificationModel.deleteTempData();
                providerDataTableSearch.deleteTempData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
