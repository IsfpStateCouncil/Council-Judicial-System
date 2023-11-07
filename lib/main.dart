import 'package:council_of_state/page/home.dart';
import 'package:council_of_state/page/login.dart';
import 'package:council_of_state/providerclasses.dart/controllerNotification.dart';
import 'package:council_of_state/providerclasses.dart/provicerdatatablesearch.dart';
import 'package:council_of_state/providerclasses.dart/providerNotificationAll.dart';
import 'package:council_of_state/providerclasses.dart/providerUserData.dart';
import 'package:council_of_state/providerclasses.dart/providerlanguage.dart';
import 'package:council_of_state/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/firebase_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProviderNotificationModel()),
      ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider()),
      ChangeNotifierProvider<ProviderDataTableSearch>(
          create: (context) => ProviderDataTableSearch()),
      ChangeNotifierProvider(
          create: (context) => ProviderNotificationAllModel()),
      ChangeNotifierProvider(create: (context) => ProviderUserData()),
    ],
    child:
        // MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData.from(
        //     colorScheme: ColorScheme.fromSeed(
        //       seedColor: Color.fromARGB(255, 241, 243, 249),
        //     ),
        //   ),
        //   initialRoute: await user_exist() == 0 ? "/" : "/home",
        //   routes: MyRoutes.myRoute(),
        // ),
        MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 241, 243, 249),
        ),
      ),
      home: await user_exist() == 0 ? const Login() : const Home(),
    ),
  ));
}
