import 'package:council_of_state/page/Splashscreen.dart';
import 'package:council_of_state/page/languagePage.dart';

import 'package:council_of_state/providerclasses.dart/controllerNotification.dart';
import 'package:council_of_state/providerclasses.dart/provicerdatatablesearch.dart';
import 'package:council_of_state/providerclasses.dart/providerNotificationAll.dart';
import 'package:council_of_state/providerclasses.dart/providerUserData.dart';
import 'package:council_of_state/providerclasses.dart/providerlanguage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/firebase_api.dart';
import 'package:council_of_state/functions/sheardpref.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  String? currentLanguage;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  SharedPreferences sharedPreferences = await PublicShread.getSheardUser();
  currentLanguage = sharedPreferences.getString("language");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProviderNotificationModel()),
      ChangeNotifierProvider<LanguageProvider>(
        create: (context) {
          if (currentLanguage != null) {
            LanguageProvider().changelanguage(currentLanguage);
          }
          return LanguageProvider();
        },
      ),
      ChangeNotifierProvider<ProviderDataTableSearch>(
          create: (context) => ProviderDataTableSearch()),
      ChangeNotifierProvider(
          create: (context) => ProviderNotificationAllModel()),
      ChangeNotifierProvider(create: (context) => ProviderUserData()),
    ],
    child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        locale: currentLanguage == "en" ? Locale('en') : Locale("ar"),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          textTheme: const TextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 241, 243, 249),
          ),
        ),
        home: currentLanguage == null ? LanguagePage() : SplashScreen()
        // await checkConnection()
        //     ? await user_exist() == 0
        //         ? const Login()
        //         : const Home()
        //     : ConnectionError(),
        ),
  ));
}
