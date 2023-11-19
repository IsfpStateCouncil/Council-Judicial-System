import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/staticdata.dart';
import '../functions/AfterBuild.dart';
import '../functions/sheardpref.dart';
import '../model/NotificationModel.dart';
import '../api/CRUD.dart';
import '../cutomwidget/NavBar.dart';
import 'package:badges/badges.dart' as badges;

import '../providerclasses.dart/providerNotificationAll.dart';
import '../providerclasses.dart/controllerNotification.dart';

class NotificationAllPage extends StatefulWidget {
  const NotificationAllPage({Key? key});
  static const routeName = "notification_All_list_screen";
  @override
  State<NotificationAllPage> createState() => _NotificationAllPageState();
}

class _NotificationAllPageState extends State<NotificationAllPage> {
  List<NotificationModel> notificationList = [];

  Crud crud = Crud();
  int count = 0;
  String? userName;
  String? password;
  String? userType;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderNotificationAllModel>(
        builder: (context, providerNotificationAllModel, child) {
      void getDataFromProvider() async {
        SharedPreferences userData = await PublicShread().getSheardUser();
        userName = userData.getString("userName").toString();
        password = userData.getString("password").toString();
        userType = userData.getString("userType");
        final myDataProvider =
            Provider.of<ProviderNotificationAllModel>(context, listen: false);
        await myDataProvider.list_Data_Class(
            "${StaticData.urlConnectionConst}${StaticData.searchForNotificationsListData}?userName=$userName&password=$password");
      }

      if (count == 0) {
        final myDataProvider =
            Provider.of<ProviderNotificationAllModel>(context, listen: false);
        if (myDataProvider.dataNotificationModel.isEmpty) {
          getDataFromProvider();
          count++;
        }
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 240, 162, 46), //<-- SEE HERE
          title: const Text("مجلس الدولة المصري"),
          elevation: 0,
          actions: [
            badges.Badge(
              badgeContent: Consumer<ProviderNotificationModel>(
                  builder: (context, providerNotificationModel, child) {
                return Text(
                    "${providerNotificationModel.dataNotificationModel.length}");
              }),
              position: badges.BadgePosition.topEnd(top: 0, end: 0),
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 35,
                ),
                onPressed: () {
                  print("tabbb");
                  //Navigator.pushNamed(context, '/Notification');
                },
              ),
              onTap: () {
                print("tabbb");
                //Navigator.pushNamed(context, '/Notification');
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: DecoratedBox(
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: Colors.white),
            //     ),
            //     child: IconButton(
            //       onPressed: () async {
            //         Navigator.pushReplacementNamed(context, 'home');
            //       },
            //       icon: const Icon(Icons.arrow_back),
            //     ),
            //   ),
            // ),
          ],
        ),
        drawer: NavBar(
            context: context, currentRoute: NotificationAllPage.routeName),
        body: providerNotificationAllModel.dataNotificationModel.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    providerNotificationAllModel.filterData(value);
                    print(providerNotificationAllModel
                        .dataNotificationModelFiltered.length);
                  },
                ),
                // MaterialButton(
                //   onPressed: () async {
                //     await providerNotificationModel.list_Data_Class(
                //         "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password");
                //   },
                //   child: Text("click"),
                // ),
                Expanded(
                  // Wrap the ListView.builder with a Container
                  // height: MediaQuery.of(context)
                  //     .size
                  //     .height, // Set a fixed height or adjust as needed
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 4,
                      );
                    },
                    itemCount: searchController.text.isEmpty
                        ? providerNotificationAllModel
                            .dataNotificationModel.length
                        : providerNotificationAllModel
                            .dataNotificationModelFiltered.length,
                    itemBuilder: (context, index) {
                      final notification = providerNotificationAllModel
                          .dataNotificationModel[index];

                      return Card(
                        color: providerNotificationAllModel
                                    .dataNotificationModel[index].opened ==
                                "3"
                            ? Colors.amber.shade200
                            : userType == 4
                                ? providerNotificationAllModel
                                            .dataNotificationModel[index]
                                            .opened ==
                                        "1"
                                    ? Colors.amber.shade200
                                    : Colors.white
                                : providerNotificationAllModel
                                            .dataNotificationModel[index]
                                            .opened ==
                                        "2"
                                    ? Colors.amber.shade200
                                    : Colors.white,
                        // Wrap each item in a Card for a better design
                        elevation: 2,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          title: Text(
                            notification.notificationData ?? '',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            notification.notificationDesc ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: providerNotificationAllModel
                                      .dataNotificationModel[index].opened ==
                                  "3"
                              ? Icon(Icons.notifications_active)
                              : userType == 4
                                  ? providerNotificationAllModel
                                              .dataNotificationModel[index]
                                              .opened ==
                                          "1"
                                      ? Icon(Icons.notifications_active)
                                      : Icon(Icons.notifications)
                                  : providerNotificationAllModel
                                              .dataNotificationModel[index]
                                              .opened ==
                                          "2"
                                      ? Icon(Icons.notifications_active)
                                      : Icon(Icons.notifications),
                          //Icon(Icons.notifications_active),
                        ),
                      );
                    },
                  ),
                ),
              ]),
      );
    });
  }
}
