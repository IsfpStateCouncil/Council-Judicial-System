import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/staticdata.dart';
import '../page/DataTableSearch.dart';
import '../page/NotificationAllPage.dart';
import '../page/home.dart';
import '../page/login.dart';
import '../providerclasses.dart/providerlanguage.dart';

class NavBar extends StatelessWidget {
  final String? userName;
  final String? password;
  final String? currentRoute;
  final BuildContext context;
  static const home = 'home_screen';
  static const datatableSearch = 'parameter_search';
  static const lisrNotification = 'notification_list_screen';
  // Constructor
  const NavBar(
      {super.key,
      required this.context,
      required this.userName,
      required this.password,
      required this.currentRoute});

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
                style: const TextStyle(fontSize: 30, color: Colors.black)),
            accountEmail: const Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
              if (currentRoute != NavBar.home) {
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
                  if (currentRoute != NavBar.home) {
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
                  if (currentRoute != NavBar.lisrNotification) {
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
                  if (currentRoute != NavBar.home) {
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
                  if (currentRoute != NavBar.lisrNotification) {
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
                  if (currentRoute != NavBar.home) {
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
                  if (currentRoute != NavBar.lisrNotification) {
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
                  if (currentRoute != NavBar.home) {
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
                  if (currentRoute != NavBar.lisrNotification) {
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
                  if (currentRoute != NavBar.home) {
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
                  if (currentRoute != NavBar.lisrNotification) {
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
              if (currentRoute != NavBar.datatableSearch) {
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
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
