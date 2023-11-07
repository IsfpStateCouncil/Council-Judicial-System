import 'package:flutter/material.dart';

import '../api/CRUD.dart';
import '../model/NotificationModel.dart';

class ProviderNotificationAllModel extends ChangeNotifier {
  Crud _crud = new Crud();
  List<NotificationModel> dataNotificationModel = [];
  List<NotificationModel> dataNotificationModelFiltered = [];

  void filterData(String searchString) {
    dataNotificationModelFiltered = dataNotificationModel
        .where((notification) =>
            notification.notificationDesc!.contains(searchString))
        .toList();
    notifyListeners();
  }

  Future<Map<String, dynamic>> Fun_get_response(String url) async {
    return await _crud.getRequest(url); // Await the response
  }

  Future<List<dynamic>> list_Data_Class(String url) async {
    try {
      Map<String, dynamic> data_response = await Fun_get_response(url);
      if (data_response.isNotEmpty) {
        List<NotificationModel> caseDataList =
            data_response['mobileNotificationsMessagesData'] != null
                ? (data_response['mobileNotificationsMessagesData'] as List)
                    .map((i) {
                    return NotificationModel.fromJson(i);
                  }).toList()
                : [];
        dataNotificationModel = caseDataList;
        notifyListeners();
        print('casesData length: ${caseDataList.length}');

        print(caseDataList[1].notificationDesc.toString());
        print("dddddd");
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
}