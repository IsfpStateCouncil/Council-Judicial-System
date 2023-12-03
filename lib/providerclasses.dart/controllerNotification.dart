import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/CRUD.dart';
import '../functions/arabicTime.dart';
import '../model/NotificationModel.dart';

class ProviderNotificationModel extends ChangeNotifier {
  Crud _crud = new Crud();
  List<NotificationModel> dataNotificationModel = [];
  List<NotificationModel> dataNotificationModelFiltered = [];

  List<NotificationModel> dataNotificationModelRequest = [];
  List<NotificationModel> dataNotificationModelSend = [];
  List<NotificationModel> dataNotificationModelSession = [];
  List<NotificationModel> dataNotificationModeldSuit = [];
  List<NotificationModel> dataNotificationModelFine = [];
  List<NotificationModel> dataNotificationModelTempSession = [];
  List<NotificationModel> dataNotificationOther = [];
  String searchValue = "";
  // List<String> collections = [
  //   "dataNotificationModelRequest",
  //   "dataNotificationModelSend",
  //   "dataNotificationModelSession",
  //   "dataNotificationModeldSuit",
  //   "dataNotificationModelFine",
  //   "dataNotificationModelTempSession"
  // ];

  get myNotificationList =>
      searchValue == "" ? dataNotificationModel : dataNotificationModelFiltered;

  void filterData(String searchString) {
    dataNotificationModelFiltered = dataNotificationModel
        .where((notification) =>
            notification.notificationDesc!.contains(searchString))
        .toList();
    notifyListeners();
  }

  Future<Map<String, dynamic>> funGetResponse(String url) async {
    return await _crud.getRequest(url); // Await the response
  }

  Future<List<dynamic>> getUnreadNotifications(String url, String type) async {
    try {
      Map<String, dynamic> data_response = await funGetResponse(url);
      if (data_response.isNotEmpty) {
        List<NotificationModel> caseDataList =
            data_response['mobileNotificationsMessagesData'] != null
                ? (data_response['mobileNotificationsMessagesData'] as List)
                    .map((i) {
                    return NotificationModel.fromJson(i);
                  }).toList()
                : [];

        if (type == "dataNotificationModel") {
          dataNotificationModel = await changeDateInList(caseDataList);
        } else if (type == "dataNotificationModelRequest") {
          dataNotificationModelRequest = await changeDateInList(caseDataList);
        } else if (type == "dataNotificationModelSend") {
          dataNotificationModelSend = await changeDateInList(caseDataList);
        } else if (type == "dataNotificationModelSession") {
          dataNotificationModelSession = await changeDateInList(caseDataList);
        } else if (type == "dataNotificationModeldSuit") {
          dataNotificationModeldSuit = await changeDateInList(caseDataList);
        } else if (type == "dataNotificationModelFine") {
          dataNotificationModelFine = await changeDateInList(caseDataList);
        } else if (type == "dataNotificationModelTempSession") {
          dataNotificationModelTempSession =
              await changeDateInList(caseDataList);
        } else if (type == "dataNotificationOther") {
          dataNotificationOther = await changeDateInList(caseDataList);
        }

        // for (int i = 0; dataNotificationModel.length - 1 > i; i++) {
        //   dataNotificationModel[i].notificationDataArabic =
        //       await dataWithCurrentLanguage(
        //           dataNotificationModel[i].notificationData!);
        // }
        notifyListeners();
        // print('casesData length: ${caseDataList.length}');
        // print(caseDataList[1].notificationDesc.toString());
        // print("dddddd");
        return caseDataList;
      } else {
        print('No  found in the response.');
        return []; // Return an empty list in case of no casesData
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<void> changeDataToCurrentLanguage() async {
    for (int i = 0; dataNotificationModel.length - 1 > i; i++) {
      dataNotificationModel[i].notificationDataArabic =
          await dataWithCurrentLanguage(
              dataNotificationModel[i].notificationData!);
    }
    for (int i = 0; dataNotificationModel.length - 1 > i; i++) {
      dataNotificationModel[i].notificationDataArabic =
          await dataWithCurrentLanguage(
              dataNotificationModel[i].notificationData!);
    }
  }

  Future<List<NotificationModel>> changeDateInList(
      List<NotificationModel> myList) async {
    for (int i = 0; myList.length - 1 > i; i++) {
      myList[i].notificationDataArabic =
          await dataWithCurrentLanguage(myList[i].notificationData!);
    }
    return myList;
  }

  deleteTempData() {
    dataNotificationModel = [];
    dataNotificationModelFiltered = [];
    dataNotificationModelRequest = [];
    dataNotificationModelSend = [];
    dataNotificationModelSession = [];
    dataNotificationModeldSuit = [];
    dataNotificationModelFine = [];
    dataNotificationModelTempSession = [];
    searchValue = "";
    notifyListeners();
  }
}
