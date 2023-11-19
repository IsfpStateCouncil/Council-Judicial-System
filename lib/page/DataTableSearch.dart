import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../cutomwidget/NavBar.dart';
import '../cutomwidget/customTextFieldCurrentDate.dart';
import '../cutomwidget/customTextFieldSearch.dart';

import '../model/userModel.dart';
import '../providerclasses.dart/provicerdatatablesearch.dart';
import '../api/CRUD.dart';
import '../providerclasses.dart/providerlanguage.dart';
import '../data/staticdata.dart';

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
  String serailNumber = "رقم المسلسل";
  String year = "السنة";
  String dateFrom = "من تاريخ";
  String dateTo = "الي تاريخ";
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
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   if (await InternetConnectionChecker().hasConnection) {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) {
    //       return user_exist() == 0 ? Login() : Home();
    //     }), (Route<dynamic> route) => false);
    //   } else {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) {
    //       return ConnectionError();
    //     }), (Route<dynamic> route) => false);
    //   }
    // });
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: true);

    return MaterialApp(home: Consumer<ProviderDataTableSearch>(
        builder: (context, providerDataTableSearch, child) {
      if (i < 3) {
        providerDataTableSearch.getAllJudgueYears();
        providerDataTableSearch.getAllCaseStatus();
        i++;
      }
      //providerDataTableSearch.getAllJudgueYears();
      return Scaffold(
        drawer: NavBar(
          context: context,
          currentRoute: parameterSearch.routeName,
        ),
        appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 240, 162, 46), //<-- SEE HERE
          title: Text(languageProvider.getCurrentData('EgyptianStateCouncil')),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFieldSearch(
                  controllerCaseNumber: _controllerCaseNumber,
                  labelText: serailNumber),
              CustomTextFieldSearch(
                  controllerCaseNumber: _controllerCaseYear, labelText: year),
              const Text(
                "حالة الدعوي",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton(
                value: dropdownvalue,
                hint: const Text('حالة الدعوي'),
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
              const Text(
                "العام القضائي",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: dropdownvalueJudgicalYea,
                hint: const Text('العام القضائي"'),
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
                  lableString: dateFrom),
              CustomTextFieldCurrenDate(
                  controllerFromDate: _controllerToDate, lableString: dateTo),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Background color
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
                child: const Text("بحث"),
              ),
              const SizedBox(
                height: 20,
              ),
              const ListTile(
                leading: CircleAvatar(
                  child: Text(
                    "رقم الدعوى",
                    style: TextStyle(fontSize: 13),
                  ),
                  radius: 40,
                ),
                title: Text("المحكمة",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(""),
                trailing: Text(
                  "الجلسة القادمة",
                  style: TextStyle(fontWeight: FontWeight.bold),
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
