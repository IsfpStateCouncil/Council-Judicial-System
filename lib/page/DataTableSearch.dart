import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../cutomwidget/NavBar.dart';
import '../cutomwidget/customAppBar.dart';
import '../cutomwidget/customTextFieldCurrentDate.dart';
import '../cutomwidget/customTextFieldSearch.dart';

import '../functions/mediaquery.dart';
import '../model/userModel.dart';
import '../providerclasses.dart/provicerdatatablesearch.dart';
import '../api/CRUD.dart';
import '../providerclasses.dart/providerlanguage.dart';
import '../data/staticdata.dart';
import 'NotificationAllPage.dart';

class parameterSearch extends StatefulWidget {
  const parameterSearch({
    Key? key,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final String userName;
  final String password;

  static const routeName = 'parameter_search';

  @override
  State<parameterSearch> createState() => DataTableSearch();
}

class DataTableSearch extends State<parameterSearch> {
  String? dropdownvalue = "-1";
  String? dropdownvalueJudgicalYea = "-1";
  int i = 0;
  final TextEditingController _controllerCaseYear = TextEditingController();
  final TextEditingController _controllerCaseNumber = TextEditingController();
  final TextEditingController _controllerFromDate = TextEditingController();
  final TextEditingController _controllerToDate = TextEditingController();
  String routeName = "/parameterSearch";
  void Function()? onTapDate;
  Future<List<UserData>> data = Future.value([]);

  Crud crud = Crud();
  int length = 0;

  List caseStatuslist = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Consumer<ProviderDataTableSearch>(
        builder: (context, providerDataTableSearch, child) {
      if (i < 3) {
        providerDataTableSearch.getAllJudgueYears();
        providerDataTableSearch.getAllCaseStatus();
        i++;
      }
      //providerDataTableSearch.getAllJudgueYears();
      final languageProvider = Provider.of<LanguageProvider>(context);
      return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(getSizePage(context, 2, 7, "appBar")),
            child: CustomAppBar(
              languageProvider: languageProvider,
            )),
        endDrawer: NavBar(
            context: context, currentRoute: NotificationAllPage.routeName),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFieldSearch(
                  controllerCaseNumber: _controllerCaseNumber,
                  labelText:
                      languageProvider.getCurrentData('squance', context)),
              CustomTextFieldSearch(
                  controllerCaseNumber: _controllerCaseYear,
                  labelText: languageProvider.getCurrentData('year', context)),
              Text(
                languageProvider.getCurrentData('casestatus', context),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton(
                value: dropdownvalue,
                hint: Text(
                    languageProvider.getCurrentData('casestatus', context)),
                items: providerDataTableSearch.datacaseDataList.map((item) {
                  return DropdownMenuItem(
                    value: item.id.toString(),
                    child: Text(item.name.toString()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    dropdownvalue = newVal; //newVal!.data;
                    print(dropdownvalue);
                    //_controllerCaseStatus.text = dropdownvalue!;
                  });
                },
              ),
              Text(
                languageProvider.getCurrentData('casestatus', context),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: dropdownvalueJudgicalYea,
                hint: Text(
                    languageProvider.getCurrentData('casestatus', context)),
                items: providerDataTableSearch.JudgicalYears.map<
                    DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item.id.toString(),
                    child: Text(item.name.toString()),
                  );
                }).toList(),
                onChanged: (String? newVal) {
                  if (newVal != null) {
                    setState(() {
                      dropdownvalueJudgicalYea = newVal;
                      print(dropdownvalueJudgicalYea);
                      // Perform additional actions as needed with the selected value
                      // _controllerCaseStatus.text = dropdownValue;
                    });
                  }
                },
              ),
              CustomTextFieldCurrenDate(
                  controllerFromDate: _controllerFromDate,
                  lableString:
                      languageProvider.getCurrentData('datefrom', context)),
              CustomTextFieldCurrenDate(
                  controllerFromDate: _controllerToDate,
                  lableString:
                      languageProvider.getCurrentData('dateTo', context)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: StaticData.button, // Background color
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  data = providerDataTableSearch.list_Data_Class(
                      '${StaticData.urlConnectionConst}${StaticData.searchCasesDataConst}',
                      <String, String>{
                        "userName": widget.userName,
                        "password": widget.password,
                        "caseYear": dropdownvalueJudgicalYea!,
                        "fromDate": _controllerFromDate.text,
                        "toDate": _controllerToDate.text,
                        "caseNumber": _controllerCaseNumber.text,
                        "caseStatusId": dropdownvalue!
                      });
                  data.then((list) {
                    length = list.length;
                    print("Length of data: $length");
                  });
                },
                child: Text(languageProvider.getCurrentData('search', context)),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  child: Text(
                    languageProvider.getCurrentData(
                        'EgyptianStateCouncil', context),
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                title: Text(
                    languageProvider.getCurrentData('thecourt', context),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                subtitle: const Text(""),
                trailing: Text(
                  languageProvider.getCurrentData('thenextsession', context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder<List<UserData>>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    print(data.toString());
                    // int i = 0;
                    return Column(
                      children: snapshot.data!.map((data) {
                        //   i++;
                        return ListTile(
                          leading: CircleAvatar(
                            //backgroundColor: Colors.amber,
                            radius: 40,
                            //backgroundColor: Colors.amber,
                            child: Text(
                                "${data.judicialYear.toString()} / ${data.serial} "),
                          ),
                          title: const Text(""),
                          subtitle: Text(
                            data.courtName.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing:
                              Text(formatDate(data.nextHearingDate.toString())),
                        );
                        // Text("${data.courtName.toString()} ");
                      }).toList(),
                    );
                  } else {
                    return const Text("No data available.");
                  }
                },
              )
            ],
          ),
        ),
      );
    }));
  }
}

String formatDate(String apiDate) {
  try {
    final parsedDate = DateTime.parse(apiDate);
    final formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    return formattedDate;
  } catch (e) {
    print(e.toString());
    return '';
  }
}
