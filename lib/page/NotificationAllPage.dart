import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cutomwidget/customAppBar.dart';
import '../data/staticdata.dart';
import '../functions/arabicTime.dart';
import '../functions/mediaquery.dart';
import '../functions/sheardpref.dart';
import '../model/NotificationModel.dart';
import '../api/CRUD.dart';
import '../cutomwidget/NavBar.dart';
import '../providerclasses.dart/providerNotificationAll.dart';

class NotificationAllPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
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
            // ignore: use_build_context_synchronously
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
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
            child: CustomAppBar()),
        drawer: NavBar(
            context: context, currentRoute: NotificationAllPage.routeName),
        body: providerNotificationAllModel.dataNotificationModel.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                TextField(
                  textDirection: StaticData.arabicTextDirection,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontFamily: StaticData.fontFamily),
                      hintText: "بحث"),
                  controller: searchController,
                  onChanged: (value) {
                    providerNotificationAllModel.filterData(value);
                  },
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
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
                      String data =
                          arabicTime(context, notification.notificationData!);
                      return Card(
                        color: providerNotificationAllModel
                                    .dataNotificationModel[index].opened ==
                                "3"
                            ? Colors.amber.shade200
                            : userType == "4"
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            data,
                            textDirection: StaticData.arabicTextDirection,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: StaticData.fontFamily),
                          ),
                          subtitle: Text(
                            notification.notificationDesc ?? '',
                            textDirection: StaticData.arabicTextDirection,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: StaticData.fontFamily),
                          ),
                          trailing: providerNotificationAllModel
                                      .dataNotificationModel[index].opened ==
                                  "3"
                              ? const Icon(Icons.notifications_active)
                              // ignore: unrelated_type_equality_checks
                              : userType == "4"
                                  ? providerNotificationAllModel
                                              .dataNotificationModel[index]
                                              .opened ==
                                          "1"
                                      ? const Icon(Icons.notifications_active)
                                      : const Icon(Icons.notifications)
                                  : providerNotificationAllModel
                                              .dataNotificationModel[index]
                                              .opened ==
                                          "2"
                                      ? const Icon(Icons.notifications_active)
                                      : const Icon(Icons.notifications),
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
