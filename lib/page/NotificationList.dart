import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cutomwidget/searchTextField.dart';
import '../data/staticdata.dart';
import '../functions/AfterBuild.dart';
import '../functions/sheardpref.dart';
import '../functions/updatenotification.dart';
import '../model/NotificationModel.dart';
import '../api/CRUD.dart';
import '../cutomwidget/NavBar.dart';
import 'package:badges/badges.dart' as badges;

import '../providerclasses.dart/controllerNotification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  static const routeName = "notification_list_screen";
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notificationList = [];

  Crud crud = Crud();
  String? userName;
  String? password;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Selector<ProviderNotificationModel, List<NotificationModel>>(
        selector: (context, providerNotificationModel) =>
            providerNotificationModel.myNotificationList,
        builder: (context, myNotificationList, child) {
          final providerNotificationModel =
              Provider.of<ProviderNotificationModel>(context, listen: false);
          void getDataFromProvider() async {
            SharedPreferences userData = await PublicShread().getSheardUser();
            userName = userData.getString("userName").toString();
            password = userData.getString("password").toString();

            await providerNotificationModel.list_Data_Class(
                "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password",
                "dataNotificationModel");
          }

          final myDataProvider =
              Provider.of<ProviderNotificationModel>(context, listen: false);
          if (myDataProvider.dataNotificationModel.isEmpty) {
            getDataFromProvider();
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
                    },
                  ),
                  onTap: () {
                    print("tabbb");
                  },
                ),
              ],
            ),
            drawer: NavBar(
                context: context, currentRoute: NotificationPage.routeName),
            body: providerNotificationModel.dataNotificationModel.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(children: [
                    SearchTextField(
                      searchController: searchController,
                      onChanged: (value) {
                        providerNotificationModel.searchValue = value;
                        providerNotificationModel.filterData(value);
                        print(providerNotificationModel
                            .dataNotificationModelFiltered.length);
                      },
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 4,
                          );
                        },
                        itemCount: searchController.text.isEmpty
                            ? providerNotificationModel
                                .dataNotificationModel.length
                            : providerNotificationModel
                                .dataNotificationModelFiltered.length,
                        itemBuilder: (context, index) {
                          final notification = providerNotificationModel
                              .dataNotificationModel[index];

                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: Colors
                                  .orange, // Change the background color to your desired color
                              child: const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (direction) async {
                              SharedPreferences userData =
                                  await PublicShread().getSheardUser();
                              userName =
                                  userData.getString("userName").toString();
                              password =
                                  userData.getString("password").toString();
                              var v = await crud.postRequest(
                                  "${StaticData.urlConnectionConst}${StaticData.editNotifictaionConst}",
                                  {
                                    "notificationId": providerNotificationModel
                                        .dataNotificationModel[index].id
                                        .toString(),
                                    "opended": providerNotificationModel
                                        .dataNotificationModel[index].opened
                                        .toString(),
                                    "userName": userName,
                                    "password": password
                                  });

                              print(v.toString());
                              // Handle dismiss action
                              await getDataNotification(context);
                            },
                            child: Card(
                              // Wrap each item in a Card for a better design
                              elevation: 2,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16),
                                title: Text(
                                  notification.notificationData ?? '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  notification.notificationDesc ?? '',
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Icon(Icons.notifications),
                              ),
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
