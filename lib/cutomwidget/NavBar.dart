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
          UserAccountsDrawerHeader(
            accountName: Text("$userName",
                style: const TextStyle(fontSize: 40, color: StaticData.font)),
            accountEmail: const Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: StaticData.backgroundColors,
              child: ClipOval(
                child: Image.asset('assets/images/logo.PNG'),
              ),
            ),
            decoration: const BoxDecoration(
                //color: Color.fromARGB(255, 234, 149, 13),
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: AssetImage(StaticData.drawerImage), // Use AssetImage
                // ),
                ),
          ),
          ListTile(
            title: Text(languageProvider.getCurrentData('mainPage')),
            leading: const Icon(Icons.home),
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
          ExpansionTile(
            title: Text(languageProvider.getCurrentData('deposit')),
            leading: const Icon(Icons.attach_money), //add icon
            childrenPadding: const EdgeInsets.only(left: 60), //children padding
            children: [
              ListTile(
                title: Text(languageProvider.getCurrentData('mainPage')),
                onTap: () {
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

              ListTile(
                title: Text(languageProvider.getCurrentData('allNotification')),
                onTap: () {
                  if (widget.currentRoute != lisrNotification) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationAllPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),

              //more child menu
            ],
          ),
          //if (components.contains("Follow Requests"))
          ExpansionTile(
            title: Text(languageProvider.getCurrentData('mainPage')),
            leading: const Icon(Icons.addchart), //add icon
            childrenPadding: const EdgeInsets.only(left: 60), //children padding
            children: [
              ListTile(
                title: Text(languageProvider.getCurrentData('order')),
                onTap: () {
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

              ListTile(
                title: Text(languageProvider.getCurrentData('fetchData')),
                onTap: () {
                  if (widget.currentRoute != lisrNotification) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationAllPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),

              //more child menu
            ],
          ),
          //if (components.contains("Schedule Hearing"))
          ExpansionTile(
            title: Text(languageProvider.getCurrentData('sessionsTime')),
            leading: const Icon(Icons.calendar_month), //add icon
            childrenPadding: const EdgeInsets.only(left: 60), //children padding
            children: [
              ListTile(
                title: Text(languageProvider.getCurrentData('mainPage')),
                onTap: () {
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

              ListTile(
                title: Text(languageProvider.getCurrentData('fetchData')),
                onTap: () {
                  if (widget.currentRoute != lisrNotification) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationAllPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),

              //more child menu
            ],
          ),
          ExpansionTile(
            title: Text(languageProvider.getCurrentData('adjurndedSessions')),
            leading: const Icon(Icons.calendar_view_week_outlined), //add icon
            childrenPadding: const EdgeInsets.only(left: 60), //children padding
            children: [
              ListTile(
                title: Text(languageProvider.getCurrentData('mainPage')),
                onTap: () {
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

              ListTile(
                title: Text(languageProvider.getCurrentData('fetchData')),
                onTap: () {
                  if (widget.currentRoute != lisrNotification) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationAllPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),

              //more child menu
            ],
          ),
          ExpansionTile(
            title: Text(languageProvider.getCurrentData('fines')),
            leading: const Icon(Icons.balance_rounded), //add icon
            childrenPadding: const EdgeInsets.only(left: 60), //children padding
            children: [
              ListTile(
                title: Text(languageProvider.getCurrentData('mainPage')),
                onTap: () {
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

              ListTile(
                title: Text(languageProvider.getCurrentData('fetchData')),
                onTap: () {
                  if (widget.currentRoute != lisrNotification) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationAllPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),

              //more child menu
            ],
          ),
          const Divider(),
          ListTile(
            title: Text(languageProvider.getCurrentData('advancedSearch')),
            leading: const Icon(Icons.wysiwyg),
            onTap: () {
              if (widget.currentRoute != datatableSearch) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => parameterSearch(
                            password: password!,
                            userName: userName!,
                          )),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
          ),

          const Divider(),
          ListTile(
            title: Text(languageProvider.getCurrentData('logout')),
            leading: const Icon(Icons.exit_to_app),
            onTap: () async {
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
        ],
      ),
    );
  }
}
