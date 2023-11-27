import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:council_of_state/page/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/CRUD.dart';
import '../cutomwidget/bodyHomePage.dart';
import '../cutomwidget/customAppBar.dart';
import '../data/staticdata.dart';
import '../functions/AwesomeConnection.dart';
import '../functions/mediaquery.dart';
import '../functions/updatenotification.dart';
import '../providerclasses.dart/controllerNotification.dart';
import '../providerclasses.dart/providerlanguage.dart';
import '../cutomwidget/NavBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = 'home_screen';

  @override
  State<Home> createState() => BarChartAPIState();
}

class BarChartAPIState extends State<Home> {
  bool loading = true;
  var fbm = FirebaseMessaging.instance;
  String? userName;
  String? password;
  String? userToken;
  Crud crud = Crud();
  static int loopingFlag = 0;
  @override
  void initState() {
    fbm.getToken().then((value) {
      final Locale locale = Localizations.localeOf(context);
      print(locale);
      userToken = value;
      FirebaseMessaging.onMessage.listen((event) {
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

  void checkUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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

  @override
  Widget build(BuildContext context) {
    if (loopingFlag < 1) {
      checkUser();
      getDataNotification(context);
      loopingFlag = loopingFlag + 1;
    }

    final languageProvider = Provider.of<LanguageProvider>(context);
    final providerNotificationModel =
        Provider.of<ProviderNotificationModel>(context);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (await InternetConnectionChecker().hasConnection) {
        if (loopingFlag == 1) {
          crud.postRequest(
              StaticData.urlConnectionConst + StaticData.insertTokenForUser, {
            "userName": userName,
            "password": password,
            "userToken": userToken
          });
        }
      } else {
        // ignore: use_build_context_synchronously
        await createAwesome(context, languageProvider);
      }
    });
    return Scaffold(
      backgroundColor: StaticData.backgroundColors,
      drawer: NavBar(
        context: context,
        currentRoute: Home.routeName,
      ),
      appBar: PreferredSize(
          preferredSize:   MediaQuery.of(context).orientation.toString() ==
            "Orientation.landscape" ?
               Size.fromHeight(getSizePage(context, 1, 7, "appBar")) :  Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
          child: CustomAppBar(
            languageProvider: languageProvider,
          )),
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
