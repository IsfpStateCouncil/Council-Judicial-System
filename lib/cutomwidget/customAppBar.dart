import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/staticdata.dart';
import '../page/NotificationList.dart';
import '../page/categoryNotification.dart';
import '../providerclasses.dart/controllerNotification.dart';
import 'package:council_of_state/main.dart' as mainapp;

import '../providerclasses.dart/providerlanguage.dart';

class CustomAppBar extends StatefulWidget {
  final languageProvider;
  final String? namePage;
  final String? language;
  final void Function()? onPressed;
  CustomAppBar({
    Key? key,
    this.languageProvider,
    this.namePage,
    this.language,
    this.onPressed,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLanguage();
    final languageProvider = Provider.of<LanguageProvider>(context);
    return AppBar(
      leading: widget.namePage == "notification_list_screen" ||
              widget.namePage == CategoryNotification.routeName
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: StaticData.button,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      backgroundColor: StaticData.appBarColor, //<-- SEE HERE
      title: Text(
        "${languageProvider.getCurrentData('EgyptianStateCouncil', context)}",
        style: TextStyle(
          color: StaticData.backgroundColors,
          fontSize: 17,
          fontFamily: StaticData.fontFamily,
          // Add other text styles as needed
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        // TextButton(
        //   onPressed: () async {
        //     SharedPreferences sharedPreferences =
        //         await SharedPreferences.getInstance();
        //     final languageProvider =
        //         Provider.of<LanguageProvider>(context, listen: false);
        //     if (currentLanguage == "ar") {
        //       sharedPreferences.setString("language", "en");
        //       languageProvider.changelanguage("en");
        //       currentLanguage = "en";
        //       widget.onPressed;
        //     } else {
        //       sharedPreferences.setString("language", "ar");
        //       languageProvider.changelanguage("ar");
        //       currentLanguage = "ar";
        //       widget.onPressed;
        //     }
        //
        //     setState(() {
        //       mainapp.main();
        //     });
        //     //
        //   },
        //   child: currentLanguage == "ar"
        //       // ignore: prefer_const_constructors
        //       ? Text(
        //           "EN",
        //           style: const TextStyle(color: StaticData.button),
        //         )
        //       // ignore: prefer_const_constructors
        //       : Text(
        //           "AR",
        //           style: const TextStyle(color: StaticData.button),
        //         ),
        // ),
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
            : SizedBox.shrink(),
      ],
    );
  }
}
