import 'package:council_of_state/providerclasses.dart/controllerNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cutomwidget/customAppBar.dart';
import '../cutomwidget/searchTextField.dart';
import '../data/staticdata.dart';
import '../functions/AwesomeConnection.dart';
import '../functions/mediaquery.dart';

import '../functions/sheardpref.dart';
import '../model/NotificationModel.dart';

import '../providerclasses.dart/providerNotificationAll.dart';
import '../providerclasses.dart/providerlanguage.dart';

class CategoryNotification extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CategoryNotification({Key? key, required this.currentList});
  final List<NotificationModel> currentList;
  static const routeName = "CategoryNotification";
  @override
  State<CategoryNotification> createState() => _CategoryNotification();
}

class _CategoryNotification extends State<CategoryNotification> {
  List<NotificationModel> notificationList = [];
  String? userType;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    getUserData();
    notificationList = widget.currentList;
    List<NotificationModel> currentList = widget.currentList;
    super.initState();
  }

  Future<void> getUserData() async {
    SharedPreferences userData = await PublicShread.getSheardUser();
    userType = userData.getString("userType");
  }

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (await InternetConnectionChecker().hasConnection) {
        //getDataNotification(context);
      } else {
        await createAwesome(context, languageProvider);
      }
    });

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: MediaQuery.of(context).orientation.toString() ==
                  "Orientation.landscape"
              ? Size.fromHeight(getSizePage(context, 1, 7, "appBar"))
              : Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
          child: CustomAppBar(
            languageProvider: languageProvider,
            namePage: CategoryNotification.routeName,
          )),
      // drawer: NavBar(
      //     context: context, currentRoute: CategoryNotification.routeName),
      body: widget.currentList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              SearchTextField(
                searchController: searchController,
                onChanged: (value) {
                  setState(() {
                    notificationList = widget.currentList
                        .where((element) =>
                    element.notificationDesc != null &&
                        element.notificationDesc!.contains(value))
                        .toList();
                  });
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
                      ? notificationList.length
                      : notificationList.length,
                  itemBuilder: (context, index) {
                    final notification = notificationList[index];
                    return Card(
                      color: notificationList[index].opened == "3"
                          ? Colors.amber.shade200
                          : userType == "4"
                              ? notificationList[index].opened == "1"
                                  ? Colors.amber.shade200
                                  : Colors.white
                              : notificationList[index].opened == "2"
                                  ? Colors.amber.shade200
                                  : Colors.white,
                      // Wrap each item in a Card for a better design
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          notificationList[index].notificationDataArabic ?? "",
                          // textDirection: StaticData.arabicTextDirection,
                          style: TextStyle(
                              color: StaticData.font,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: StaticData.fontFamily),
                        ),
                        subtitle: Text(
                          notification.notificationDesc ?? '',
                          // textDirection: StaticData.arabicTextDirection,
                          style: TextStyle(
                              color: StaticData.font,
                              fontSize: 16,
                              fontFamily: StaticData.fontFamily),
                        ),
                        trailing: notificationList[index].opened == "3"
                            ? const Icon(Icons.notifications_active)
                            // ignore: unrelated_type_equality_checks
                            : userType == "4"
                                ? notificationList[index].opened == "1"
                                    ? const Icon(Icons.notifications_active)
                                    : const Icon(Icons.notifications)
                                : notificationList[index].opened == "2"
                                    ? const Icon(Icons.notifications_active)
                                    : const Icon(Icons.notifications),
                      ),
                    );
                  },
                ),
              ),
            ]),
    );
  }
}
