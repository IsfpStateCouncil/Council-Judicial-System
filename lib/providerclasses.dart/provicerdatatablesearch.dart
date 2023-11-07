import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../api/CRUD.dart';
import '../data/staticdata.dart';
import '../model/CaseStatuseModel.dart';
import '../model/JudgicalYearDataModel.dart';
import '../model/userModel.dart';

class ProviderDataTableSearch extends ChangeNotifier {
  Crud _crud = Crud();
  List caseStatuslist = [];
  List<CaseStatuseModel> datacaseDataList = [];
  List<JudgicalYearDataModel> JudgicalYears = [];
  Future<List<UserData>> list_Data_Class(
      String url, Map<String, dynamic> mymap) async {
    try {
      Map<String, dynamic> data_response = await _crud.postRequest(url, mymap);

      if (data_response.containsKey('casesData')) {
        List<dynamic> caseDataList = data_response['casesData'] != null
            ? (data_response['casesData'] as List)
                .map((i) => UserData.fromMap(i))
                .toList()
            : [];
        notifyListeners();
        print('casesData length: ${caseDataList.length}');
        return caseDataList.cast<UserData>();
      } else {
        print('No casesData found in the response.');
        return [];
        // Return an empty list in case of no casesData
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<JudgicalYearDataModel>> getAllJudgueYears() async {
    try {
      String url =
          "${StaticData.urlConnectionConst}${StaticData.getAllJudgueYears}";
      Map<String, dynamic> mymap;
      Map<String, String> user = await getUser();
      mymap = {
        "userName": "${user['userName']}",
        "password": "${user['password']}"
      };
      Map<String, dynamic> data_response = await _crud.postRequest(url, mymap);

      if (data_response.containsKey('judgicalYearData')) {
        List<dynamic> judgicalYearDataList =
            data_response['judgicalYearData'] != null
                ? (data_response['judgicalYearData'] as List)
                    .map((i) => JudgicalYearDataModel.fromJson(i))
                    .toList()
                : [];
        notifyListeners();
        JudgicalYears = judgicalYearDataList.cast<JudgicalYearDataModel>();
        JudgicalYears.sort((a, b) => b.name!.compareTo(a.name!));
        JudgicalYears.insert(0, JudgicalYearDataModel(id: -1, name: "الكل"));
        notifyListeners();
        return judgicalYearDataList.cast<JudgicalYearDataModel>();
      } else {
        print('No judgicalYearData found in the response.');
        return [];
        // Return an empty list in case of no casesData
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future getAllCaseStatus() async {
    try {
      Map<String, String> user = await getUser();
      Map<String, dynamic> data_response = await _crud.getRequest(
          "${StaticData.urlConnectionConst}${StaticData.findAllCaseStatusConst}?userName=${user['userName']}&password=${user['password']}");
      if (data_response.isNotEmpty) {
        List<CaseStatuseModel> caseDataList =
            data_response['caseStatusesData'] != null
                ? (data_response['caseStatusesData'] as List).map((i) {
                    return CaseStatuseModel.fromJson(i);
                  }).toList()
                : [];
        datacaseDataList = caseDataList;
        datacaseDataList.insert(0, CaseStatuseModel(id: -1, name: "الكل"));
        notifyListeners();
      } else {
        print(
            'No  found in the response.'); // Return an empty list in case of no casesData
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<Map<String, String>> getUser() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> user = {
      "userName": prefs.getString("userName")!,
      "password": prefs.getString("password")!
    };
    return user;
  } catch (e) {
    print(e.toString());
    return {};
  }
}
