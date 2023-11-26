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
