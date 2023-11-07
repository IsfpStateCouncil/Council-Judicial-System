import 'package:council_of_state/cutomwidget/textAnimationWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/mediaquery.dart';
import '../providerclasses.dart/controllerNotification.dart';
import '../providerclasses.dart/providerlanguage.dart';
import 'cutomMaterialApp.dart';

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({
    super.key,
    required this.languageProvider,
    required this.providerNotificationModel,
    required this.namePage,
  });

  final LanguageProvider languageProvider;
  final ProviderNotificationModel providerNotificationModel;
  final String namePage;

  Future<void> changeLanguage(String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", type);
    languageProvider.language = prefs.getString("language");
    print(languageProvider.language);
    print(languageProvider.language);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextAnimationWidget(),
              //cahnge language
              // ElevatedButton(
              //     onPressed: () async {
              //       await changeLanguage("ar");
              //       Navigator.pushReplacementNamed(context, 'home');
              //     },
              //     child: Text("cahneg langaue ar")),
              // ElevatedButton(
              //     onPressed: () async {
              //       await changeLanguage("en");
              //       Navigator.pushReplacementNamed(context, 'home');
              //     },
              //     child: Text("cahneg langaue en")),
              Visibility(
                visible: true,
                child: Container(
                    padding: EdgeInsets.only(top: 5),
                    height: GetSizePage(context, 2, 18, namePage),
                    width: GetSizePage(context, 1, 100, namePage),
                    child: CutomMaterialApp(
                      count: providerNotificationModel
                          .dataNotificationModelRequest.length,
                      name: languageProvider.getCurrentData("requestedOrder"),
                      color: Color.fromARGB(255, 124, 116, 93),
                      iconData: Icons.south_outlined,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  height: GetSizePage(context, 2, 18, namePage),
                  width: GetSizePage(context, 1, 100, namePage),
                  child: CutomMaterialApp(
                    count: providerNotificationModel
                        .dataNotificationModelSend.length,
                    name: languageProvider.getCurrentData("sendedOrder"),
                    color: Color.fromARGB(255, 126, 114, 78),
                    iconData: Icons.north_outlined,
                  )),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  height: GetSizePage(context, 2, 18, namePage),
                  width: GetSizePage(context, 1, 100, namePage),
                  child: CutomMaterialApp(
                    count: providerNotificationModel
                        .dataNotificationModelSession.length,
                    name: languageProvider.getCurrentData("sessions"),
                    color: Color.fromARGB(255, 126, 110, 65),
                    iconData: Icons.gavel,
                  )),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  height: GetSizePage(context, 2, 18, namePage),
                  width: GetSizePage(context, 1, 100, namePage),
                  child: CutomMaterialApp(
                    count: providerNotificationModel
                        .dataNotificationModeldSuit.length,
                    name: languageProvider.getCurrentData("suits"),
                    color: Color.fromARGB(255, 139, 118, 60),
                    iconData: Icons.how_to_vote,
                  )),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  height: GetSizePage(context, 2, 18, namePage),
                  width: GetSizePage(context, 1, 100, namePage),
                  child: CutomMaterialApp(
                    count: providerNotificationModel
                        .dataNotificationModelFine.length,
                    name: languageProvider.getCurrentData("fines"),
                    color: Color.fromARGB(255, 160, 132, 54),
                    iconData: Icons.account_balance_wallet,
                  )),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  height: GetSizePage(context, 2, 18, namePage),
                  width: GetSizePage(context, 1, 100, namePage),
                  child: CutomMaterialApp(
                    count: providerNotificationModel
                        .dataNotificationModelTempSession.length,
                    name: languageProvider.getCurrentData("adjurndedSessions"),
                    color: Color.fromARGB(255, 173, 134, 15),
                    iconData: Icons.access_time,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
