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
import '../functions/updatenotification.dart';
import '../model/NotificationModel.dart';
import '../api/CRUD.dart';
import '../cutomwidget/NavBar.dart';
import '../providerclasses.dart/controllerNotification.dart';
import '../providerclasses.dart/providerlanguage.dart';

class NotificationPage extends StatefulWidget {
  final String? notificationType;
  const NotificationPage({super.key, required this.notificationType});
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
    final languageProvider = Provider.of<LanguageProvider>(context);
    if (widget.notificationType == "sessions") {
      return Selector<ProviderNotificationModel, List<NotificationModel>>(
          selector: (context, providerNotificationModel) =>
              providerNotificationModel.dataNotificationModelSession,
          builder: (context, dataNotificationModelSession, child) {
            final providerNotificationModel =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            void getDataFromProvider() async {
              SharedPreferences userData = await PublicShread.getSheardUser();
              userName = userData.getString("userName").toString();
              password = userData.getString("password").toString();

              await providerNotificationModel.getUnreadNotifications(
                  "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password",
                  "dataNotificationModel");
            }

            final myDataProvider =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            if (myDataProvider.dataNotificationModel.isEmpty) {
              getDataFromProvider();
            }
            SchedulerBinding.instance.addPostFrameCallback((_) async {
              if (await InternetConnectionChecker().hasConnection) {
                //getDataNotification(context);
              } else {
                await createAwesome(context, languageProvider);
              }
            });
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
                  child: CustomAppBar(
                    languageProvider: languageProvider,
                  )),
              drawer: NavBar(
                  context: context, currentRoute: NotificationPage.routeName),
              body: providerNotificationModel
                      .dataNotificationModelSession.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(children: [
                      SearchTextField(
                        searchController: searchController,
                        onChanged: (value) {
                          providerNotificationModel.searchValue = value;
                          providerNotificationModel.filterData(value);
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
                              ? providerNotificationModel
                                  .dataNotificationModelSession.length
                              : providerNotificationModel
                                  .dataNotificationModelFiltered.length,
                          itemBuilder: (context, index) {
                            final notification = providerNotificationModel
                                .dataNotificationModel[index];
                            // String data = arabicTime(
                            //     context, notification.notificationData!);
                            return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: StaticData
                                    .button, // Change the background color to your desired color
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) async {
                                SharedPreferences userData =
                                    await PublicShread.getSheardUser();
                                userName =
                                    userData.getString("userName").toString();
                                password =
                                    userData.getString("password").toString();
                                await crud.postRequest(
                                    "${StaticData.urlConnectionConst}${StaticData.editNotifictaionConst}",
                                    {
                                      "notificationId":
                                          providerNotificationModel
                                              .dataNotificationModelSession[
                                                  index]
                                              .id
                                              .toString(),
                                      "opended": providerNotificationModel
                                          .dataNotificationModelSession[index]
                                          .opened
                                          .toString(),
                                      "userName": userName,
                                      "password": password
                                    });

                                // ignore: use_build_context_synchronously
                                await getDataNotification(context);
                              },
                              child: Card(
                                // Wrap each item in a Card for a better design
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    providerNotificationModel
                                            .dataNotificationModelSession[index]
                                            .notificationDataArabic ??
                                        '',
                                    textDirection:
                                        StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontFamily: StaticData.fontFamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    notification.notificationDesc ?? '',
                                    textDirection:
                                        StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontSize: 16,
                                        fontFamily: StaticData.fontFamily),
                                  ),
                                  trailing: const Icon(Icons.notifications),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
            );
          });
    } else if (widget.notificationType == "adjurndedSessions") {
      return Selector<ProviderNotificationModel, List<NotificationModel>>(
          selector: (context, providerNotificationModel) =>
              providerNotificationModel.dataNotificationModelTempSession,
          builder: (context, dataNotificationModelTempSession, child) {
            final providerNotificationModel =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            void getDataFromProvider() async {
              SharedPreferences userData = await PublicShread.getSheardUser();
              userName = userData.getString("userName").toString();
              password = userData.getString("password").toString();

              await providerNotificationModel.getUnreadNotifications(
                  "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password",
                  "dataNotificationModel");
            }

            final myDataProvider =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            if (myDataProvider.dataNotificationModel.isEmpty) {
              getDataFromProvider();
            }
            SchedulerBinding.instance.addPostFrameCallback((_) async {
              if (await InternetConnectionChecker().hasConnection) {
                //getDataNotification(context);
              } else {
                await createAwesome(context, languageProvider);
              }
            });
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
                  child: CustomAppBar(
                    languageProvider: languageProvider,
                  )),
              drawer: NavBar(
                  context: context, currentRoute: NotificationPage.routeName),
              body: providerNotificationModel
                      .dataNotificationModelTempSession.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(children: [
                      SearchTextField(
                        searchController: searchController,
                        onChanged: (value) {
                          providerNotificationModel.searchValue = value;
                          providerNotificationModel.filterData(value);
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
                              ? providerNotificationModel
                                  .dataNotificationModelTempSession.length
                              : providerNotificationModel
                                  .dataNotificationModelFiltered.length,
                          itemBuilder: (context, index) {
                            final notification = providerNotificationModel
                                .dataNotificationModel[index];
                            // String data = arabicTime(
                            //     context, notification.notificationData!);
                            return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: StaticData
                                    .button, // Change the background color to your desired color
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) async {
                                SharedPreferences userData =
                                    await PublicShread.getSheardUser();
                                userName =
                                    userData.getString("userName").toString();
                                password =
                                    userData.getString("password").toString();
                                await crud.postRequest(
                                    "${StaticData.urlConnectionConst}${StaticData.editNotifictaionConst}",
                                    {
                                      "notificationId":
                                          providerNotificationModel
                                              .dataNotificationModelTempSession[
                                                  index]
                                              .id
                                              .toString(),
                                      "opended": providerNotificationModel
                                          .dataNotificationModelTempSession[
                                              index]
                                          .opened
                                          .toString(),
                                      "userName": userName,
                                      "password": password
                                    });

                                // ignore: use_build_context_synchronously
                                await getDataNotification(context);
                              },
                              child: Card(
                                // Wrap each item in a Card for a better design
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    providerNotificationModel
                                            .dataNotificationModelTempSession[
                                                index]
                                            .notificationDataArabic ??
                                        '',
                                    textDirection:
                                        StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontFamily: StaticData.fontFamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    notification.notificationDesc ?? '',
                                    textDirection:
                                        StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontSize: 16,
                                        fontFamily: StaticData.fontFamily),
                                  ),
                                  trailing: const Icon(Icons.notifications),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
            );
          });
    } else if (widget.notificationType == "requestedOrder" ||
        widget.notificationType == "sendedOrder" ||
        widget.notificationType == "suits" ||
        widget.notificationType == "fines") {
      return Selector<ProviderNotificationModel, List<NotificationModel>>(
          selector: (context, providerNotificationModel) =>
              providerNotificationModel.dataNotificationModelFine,
          builder: (context, dataNotificationModelFine, child) {
            final providerNotificationModel =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            void getDataFromProvider() async {
              SharedPreferences userData = await PublicShread.getSheardUser();
              userName = userData.getString("userName").toString();
              password = userData.getString("password").toString();

              await providerNotificationModel.getUnreadNotifications(
                  "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password",
                  "dataNotificationModel");
            }

            final myDataProvider =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            if (myDataProvider.dataNotificationModel.isEmpty) {
              getDataFromProvider();
            }
            SchedulerBinding.instance.addPostFrameCallback((_) async {
              if (await InternetConnectionChecker().hasConnection) {
                //getDataNotification(context);
              } else {
                await createAwesome(context, languageProvider);
              }
            });
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
                  child: CustomAppBar(
                    languageProvider: languageProvider,
                  )),
              drawer: NavBar(
                  context: context, currentRoute: NotificationPage.routeName),
              body: providerNotificationModel.dataNotificationModelFine.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(children: [
                      SearchTextField(
                        searchController: searchController,
                        onChanged: (value) {
                          providerNotificationModel.searchValue = value;
                          providerNotificationModel.filterData(value);
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
                              ? providerNotificationModel
                                  .dataNotificationModelFine.length
                              : providerNotificationModel
                                  .dataNotificationModelFiltered.length,
                          itemBuilder: (context, index) {
                            final notification = providerNotificationModel
                                .dataNotificationModel[index];
                            // String data = arabicTime(
                            //     context, notification.notificationData!);
                            return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: StaticData
                                    .button, // Change the background color to your desired color
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) async {
                                SharedPreferences userData =
                                    await PublicShread.getSheardUser();
                                userName =
                                    userData.getString("userName").toString();
                                password =
                                    userData.getString("password").toString();
                                await crud.postRequest(
                                    "${StaticData.urlConnectionConst}${StaticData.editNotifictaionConst}",
                                    {
                                      "notificationId":
                                          providerNotificationModel
                                              .dataNotificationModelFine[index]
                                              .id
                                              .toString(),
                                      "opended": providerNotificationModel
                                          .dataNotificationModelFine[index]
                                          .opened
                                          .toString(),
                                      "userName": userName,
                                      "password": password
                                    });

                                // ignore: use_build_context_synchronously
                                await getDataNotification(context);
                              },
                              child: Card(
                                // Wrap each item in a Card for a better design
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    providerNotificationModel
                                            .dataNotificationModelFine[index]
                                            .notificationDataArabic ??
                                        '',
                                    textDirection:
                                        StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontFamily: StaticData.fontFamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    notification.notificationDesc ?? '',
                                    textDirection:
                                        StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontSize: 16,
                                        fontFamily: StaticData.fontFamily),
                                  ),
                                  trailing: const Icon(Icons.notifications),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
            );
          });
    } else {
      return Selector<ProviderNotificationModel, List<NotificationModel>>(
          selector: (context, providerNotificationModel) =>
              providerNotificationModel.myNotificationList,
          builder: (context, myNotificationList, child) {
            final providerNotificationModel =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            void getDataFromProvider() async {
              SharedPreferences userData = await PublicShread.getSheardUser();
              userName = userData.getString("userName").toString();
              password = userData.getString("password").toString();

              await providerNotificationModel.getUnreadNotifications(
                  "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password",
                  "dataNotificationModel");
            }

            final myDataProvider =
                Provider.of<ProviderNotificationModel>(context, listen: false);
            if (myDataProvider.dataNotificationModel.isEmpty) {
              getDataFromProvider();
            }
            SchedulerBinding.instance.addPostFrameCallback((_) async {
              if (await InternetConnectionChecker().hasConnection) {
                //getDataNotification(context);
              } else {
                await createAwesome(context, languageProvider);
              }
            });
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
                  child: CustomAppBar(
                    languageProvider: languageProvider,
                  )),
              drawer: NavBar(
                  context: context, currentRoute: NotificationPage.routeName),
              body: providerNotificationModel.dataNotificationModel.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(children: [
                      SearchTextField(
                        searchController: searchController,
                        onChanged: (value) {
                          providerNotificationModel.searchValue = value;
                          providerNotificationModel.filterData(value);
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
                              ? providerNotificationModel
                                  .dataNotificationModel.length
                              : providerNotificationModel
                                  .dataNotificationModelFiltered.length,
                          itemBuilder: (context, index) {
                            final notification = providerNotificationModel
                                .dataNotificationModel[index];
                            // String data = arabicTime(
                            //     context, notification.notificationData!);
                            return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: StaticData
                                    .button, // Change the background color to your desired color
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) async {
                                SharedPreferences userData =
                                    await PublicShread.getSheardUser();
                                userName =
                                    userData.getString("userName").toString();
                                password =
                                    userData.getString("password").toString();
                                await crud.postRequest(
                                    "${StaticData.urlConnectionConst}${StaticData.editNotifictaionConst}",
                                    {
                                      "notificationId":
                                          providerNotificationModel
                                              .dataNotificationModel[index].id
                                              .toString(),
                                      "opended": providerNotificationModel
                                          .dataNotificationModel[index].opened
                                          .toString(),
                                      "userName": userName,
                                      "password": password
                                    });

                                // ignore: use_build_context_synchronously
                                await getDataNotification(context);
                              },
                              child: Card(
                                // Wrap each item in a Card for a better design
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    providerNotificationModel
                                        .dataNotificationModel[index]
                                        .notificationDataArabic!,
                                    // textDirection: StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontFamily: StaticData.fontFamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    notification.notificationDesc ?? '',
                                    // textDirection: StaticData.arabicTextDirection,
                                    style: TextStyle(
                                        color: StaticData.font,
                                        fontSize: 16,
                                        fontFamily: StaticData.fontFamily),
                                  ),
                                  trailing: const Icon(Icons.notifications),
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
}
