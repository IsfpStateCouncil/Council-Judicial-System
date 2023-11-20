import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/staticdata.dart';
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
    required this.onRefresh,
  });

  final LanguageProvider languageProvider;
  final ProviderNotificationModel providerNotificationModel;
  final String namePage;
  final Future<void> Function() onRefresh;

  Future<void> changeLanguage(String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", type);
    languageProvider.language = prefs.getString("language");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          primary: false,
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            cellDesign(context, "requestedOrder", Icons.south_outlined,
                providerNotificationModel.dataNotificationModelRequest.length),
            cellDesign(context, "sendedOrder", Icons.north_outlined,
                providerNotificationModel.dataNotificationModelSend.length),
            cellDesign(context, "sessions", Icons.gavel,
                providerNotificationModel.dataNotificationModelSession.length),
            cellDesign(context, "suits", Icons.how_to_vote,
                providerNotificationModel.dataNotificationModeldSuit.length),
            cellDesign(context, "fines", Icons.account_balance_wallet,
                providerNotificationModel.dataNotificationModelFine.length),
            cellDesign(
                context,
                "adjurndedSessions",
                Icons.access_time,
                providerNotificationModel
                    .dataNotificationModelTempSession.length),
          ],
        ),

        // child: Column(
        //   mainAxisSize: MainAxisSize.max,
        //   children: [
        //     TextAnimationWidget(),
        //     //cahnge language
        //     // ElevatedButton(
        //     //     onPressed: () async {
        //     //       await changeLanguage("ar");
        //     //       Navigator.pushReplacementNamed(context, 'home');
        //     //     },
        //     //     child: Text("cahneg langaue ar")),
        //     // ElevatedButton(
        //     //     onPressed: () async {
        //     //       await changeLanguage("en");
        //     //       Navigator.pushReplacementNamed(context, 'home');
        //     //     },
        //     //     child: Text("cahneg langaue en")),
        //     Visibility(
        //       visible: true,
        //       // child: Container(
        //       //     padding: EdgeInsets.only(top: 5),
        //       //     height: GetSizePage(context, 2, 18, namePage),
        //       //     width: GetSizePage(context, 1, 100, namePage),
        //       //     child: CutomMaterialApp(
        //       //       count: providerNotificationModel
        //       //           .dataNotificationModelRequest.length,
        //       //       name: languageProvider.getCurrentData("requestedOrder"),
        //       //       color: StaticData.button,
        //       //       iconData: Icons.south_outlined,
        //       //       textColor: StaticData.backgroundColors, fontFamily: StaticData.fontFamily,
        //       //     )),
        //     ),
        //     cellDesign(context, "sendedOrder",Icons.north_outlined),
        //     cellDesign(context, "sessions",Icons.gavel),
        //     cellDesign(context, "suits",Icons.how_to_vote),
        //     cellDesign(context, "fines",Icons.account_balance_wallet),
        //     cellDesign(context, "adjurndedSessions",Icons.access_time),
        //     // Container(
        //     //     padding: EdgeInsets.only(top: 5),
        //     //     height: GetSizePage(context, 2, 18, namePage),
        //     //     width: GetSizePage(context, 1, 100, namePage),
        //     //     child: CutomMaterialApp(
        //     //       count: providerNotificationModel
        //     //           .dataNotificationModelSend.length,
        //     //       name: languageProvider.getCurrentData("sendedOrder"),
        //     //       color: StaticData.button,
        //     //       iconData: Icons.north_outlined,
        //     //       textColor: StaticData.backgroundColors, fontFamily: StaticData.fontFamily,
        //     //     )),
        //     // Container(
        //     //     padding: EdgeInsets.only(top: 5),
        //     //     height: GetSizePage(context, 2, 18, namePage),
        //     //     width: GetSizePage(context, 1, 100, namePage),
        //     //     child: CutomMaterialApp(
        //     //       count: providerNotificationModel
        //     //           .dataNotificationModelSession.length,
        //     //       name: languageProvider.getCurrentData("sessions"),
        //     //       color: StaticData.button,
        //     //       iconData: Icons.gavel,
        //     //       textColor: StaticData.backgroundColors, fontFamily: StaticData.fontFamily,
        //     //     )),
        //     // Container(
        //     //     padding: EdgeInsets.only(top: 5),
        //     //     height: GetSizePage(context, 2, 18, namePage),
        //     //     width: GetSizePage(context, 1, 100, namePage),
        //     //     child: CutomMaterialApp(
        //     //       count: providerNotificationModel
        //     //           .dataNotificationModeldSuit.length,
        //     //       name: languageProvider.getCurrentData("suits"),
        //     //       color: StaticData.button,
        //     //       iconData: Icons.how_to_vote,
        //     //       textColor: StaticData.backgroundColors, fontFamily: StaticData.fontFamily,
        //     //     )),
        //     // Container(
        //     //     padding: EdgeInsets.only(top: 5),
        //     //     height: GetSizePage(context, 2, 18, namePage),
        //     //     width: GetSizePage(context, 1, 100, namePage),
        //     //     child: CutomMaterialApp(
        //     //       count: providerNotificationModel
        //     //           .dataNotificationModelFine.length,
        //     //       name: languageProvider.getCurrentData("fines"),
        //     //       color: StaticData.button,
        //     //       iconData: Icons.account_balance_wallet,
        //     //       textColor: StaticData.backgroundColors, fontFamily: StaticData.fontFamily,
        //     //     )),
        //     // Container(
        //     //     padding: EdgeInsets.only(top: 5),
        //     //     height: GetSizePage(context, 2, 18, namePage),
        //     //     width: GetSizePage(context, 1, 100, namePage),
        //     //     child: CutomMaterialApp(
        //     //       count: providerNotificationModel
        //     //           .dataNotificationModelTempSession.length,
        //     //       name: languageProvider.getCurrentData("adjurndedSessions"),
        //     //       color: StaticData.button,
        //     //       iconData: Icons.access_time,
        //     //       textColor: StaticData.backgroundColors, fontFamily: StaticData.fontFamily,
        //     //     )
        //     //     ),
        //   ],
        // ),
      ),
    );
  }

  Widget cellDesign(
      BuildContext context, String type, IconData icon, int count) {
    return Visibility(
        visible: true,
        child: Card(
          elevation: 10,
          color:
              StaticData.appBarColor, // Adjust the shadow elevation as needed
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5), // Adjust the corner radius as needed
          ),

          child: Container(
              //padding: EdgeInsets.only(top: 5, left: 5),
              height: getSizePage(context, 2, 18, namePage),
              width: getSizePage(context, 1, 100, namePage),
              child: CutomMaterialApp(
                count: count,
                name:
                    languageProvider.getCurrentData(type), //"adjurndedSessions"
                color: StaticData.button,
                iconData: icon,
                textColor: StaticData.backgroundColors,
                fontFamily: StaticData.fontFamily,
              )),
        ));
  }
}
