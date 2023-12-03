import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/staticdata.dart';
import '../page/NotificationList.dart';
import '../providerclasses.dart/controllerNotification.dart';
import 'package:council_of_state/main.dart' as mainapp;

class CustomAppBar extends StatefulWidget {
  final languageProvider;
  final String? namePage;
  CustomAppBar({
    Key? key,
    this.languageProvider,
    this.namePage,
  }) : super(key: key);

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  String? currentLanguage;
  Future<void> getCurrentLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    currentLanguage = sharedPreferences.getString("language");
  }

  Future<void> setCurrentLanguage(String language) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("language", language);
    widget.languageProvider.changelanguage(language);
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLanguage();

    return AppBar(
      backgroundColor: StaticData.appBarColor, //<-- SEE HERE
      title: Text(
        "${widget.languageProvider.getCurrentData('EgyptianStateCouncil')}",
        style: TextStyle(
          fontSize: 17,
          fontFamily: StaticData.fontFamily,
          // Add other text styles as needed
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () async {
            if (currentLanguage == "ar") {
              await setCurrentLanguage("en");
              currentLanguage = "en";
            } else {
              await setCurrentLanguage("ar");
              currentLanguage = "ar";
            }

            setState(() {
              mainapp.main();
            });
            //
          },
          child: currentLanguage == "ar"
              // ignore: prefer_const_constructors
              ? Text(
                  "EN",
                  style: const TextStyle(color: StaticData.button),
                )
              // ignore: prefer_const_constructors
              : Text(
                  "AR",
                  style: const TextStyle(color: StaticData.button),
                ),
        ),
        widget.namePage != "notification_list_screen" &&
                widget.namePage != "notification_All_list_screen"
            ? badges.Badge(
                badgeContent: Consumer<ProviderNotificationModel>(
                    builder: (context, providerNotificationModel, child) {
                  return Text(
                    "${providerNotificationModel.dataNotificationModel.length}",
                    style: TextStyle(color: Colors.white),
                  );
                }),
                position: badges.BadgePosition.topEnd(top: 5, end: 5),
                child: IconButton(
                  icon: const Icon(
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
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()),
                  );
                },
              )
            : Text(""),
      ],
    );
  }
}
