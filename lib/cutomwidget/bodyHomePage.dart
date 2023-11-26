import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/staticdata.dart';
import '../functions/mediaquery.dart';

import '../page/NotificationList.dart';
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
          gridDelegate: MediaQuery.of(context).orientation.toString() ==
                  "Orientation.landscape"
              ? SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10)
              : SliverGridDelegateWithFixedCrossAxisCount(
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
    BuildContext context,
    String type,
    IconData icon,
    int count,
  ) {
    return Visibility(
      visible: true,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  NotificationPage(notificationType: type,)),
            );
        },
        child: Card(
          elevation: 10,
          color: StaticData.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: EdgeInsets.all(10), // Adjust padding as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40, // Adjust the size according to your needs
                  color: StaticData.backgroundColors, // Add color to the icon
                ),
                SizedBox(height: 5),
                Text(
                  languageProvider.getCurrentData(type),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: StaticData.backgroundColors,
                    fontFamily: StaticData.fontFamily,
                    fontSize:
                        17, // Adjust the font size according to your needs
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '$count',
                  style: TextStyle(
                    color: StaticData.backgroundColors,
                    fontFamily: StaticData.fontFamily,
                    fontSize:
                        20, // Adjust the font size according to your needs
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
