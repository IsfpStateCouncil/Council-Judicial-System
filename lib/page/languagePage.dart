import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart' as mainApp;
import '../data/staticdata.dart';
import '../providerclasses.dart/providerlanguage.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Image.asset(
            StaticData.imageLogo,
            height: 300,
            width: 300,
          ),
          changerLanguageButton(() async {
            final languageProvider =
                Provider.of<LanguageProvider>(context, listen: false);
            languageProvider.changelanguage("ar");
            languageProvider.language = "ar";
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString("language", "ar");

            //   await setCurrentLanguage("ar", context);
            mainApp.main();
          }, "عربي"),
          changerLanguageButton(() async {
            final languageProvider =
                Provider.of<LanguageProvider>(context, listen: false);
            languageProvider.changelanguage("en");
            languageProvider.language = "en";
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString("language", "en");

            //    await setCurrentLanguage("ar", context);
            mainApp.main();
          }, "English"),
        ],
      )),
    );
  }

  Padding changerLanguageButton(
      Future<void> Function()? onPressed, String name) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: MaterialButton(
        elevation: 30,
        color: StaticData.button,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          // margin: EdgeInsets.all(20),
          alignment: Alignment.center,
          width: 200,
          child: Text(name,
              style: TextStyle(
                  color: StaticData.backgroundColors,
                  fontFamily: StaticData.fontFamily,
                  fontSize: 40)),
        ),
      ),
    );
  }
}
