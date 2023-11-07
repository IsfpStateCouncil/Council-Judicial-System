import 'package:council_of_state/page/DataTableSearch.dart';
import 'package:council_of_state/page/ErrorPage.dart';
import 'package:council_of_state/page/NotificationAllPage.dart';
import 'package:council_of_state/page/NotificationList.dart';
import 'package:council_of_state/page/Splashscreen.dart';
import 'package:council_of_state/page/home.dart';
import 'package:council_of_state/page/login.dart';
import 'package:flutter/material.dart';
//import 'package:login_flutter/page/NotificationAllPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRoutes {
  static Map<String, Widget Function(BuildContext)> myRoute() {
    return {
      '/': (BuildContext context) => SplashScreen(),
      '/home': (BuildContext context) => Home(),
      '/Notification': (BuildContext context) => NotificationPage(),
      '/login': (BuildContext context) => Login(),
      '/error': (BuildContext context) => ErrorPage(),
      '/NotificationAll': (BuildContext context) => NotificationAllPage(),
      '/parameterSearch': (BuildContext context) {
        Map<String, dynamic>? arguments =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        print(arguments);
        return parameterSearch(
          password: arguments?["password"],
          userName: arguments?["userName"],
        );
      },
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name!) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: const RouteSettings(arguments: SplashScreen.routeName),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const Login(),
          settings: const RouteSettings(arguments: Login.routeName),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => Home(),
          settings: const RouteSettings(arguments: Home.routeName),
        );
      case '/Notification':
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/error':
        return MaterialPageRoute(builder: (_) => ErrorPage());
      case '/NotificationAll':
        return MaterialPageRoute(builder: (_) => NotificationAllPage());
      case '/parameterSearch':
        return MaterialPageRoute(
          builder: (_) {
            final Map<String, dynamic>? parameterMap =
                settings.arguments as Map<String, dynamic>?;
            print(parameterMap);
            return parameterSearch(
              password: parameterMap?["password"],
              userName: parameterMap?["userName"],
            );
          },
          settings: const RouteSettings(arguments: parameterSearch.routeName),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
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

Future<String> getUsername() async {
  try {
    String userName; //, password,id;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userName = prefs.getString("userName")!;
    //password = prefs.getString("password");
    return userName;
  } catch (e) {
    return "";
  }
}

Future<String> getPassword() async {
  try {
    String password; //, password,id;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    password = prefs.getString("password")!;
    //password = prefs.getString("password");
    return password;
  } catch (e) {
    return "";
  }
}
