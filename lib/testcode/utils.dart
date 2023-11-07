// class Utils {
//   static List<T> modelBuilder<M, T>(
//           List<M> models, T Function(int index, M model) builder) =>
//       models
//           .asMap()
//           .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
//           .values
//           .toList();
// }




                  
// FutureBuilder<List<Class_data>>(
              //   future: data,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator();
              //     } else if (snapshot.hasError) {
              //       return Text(snapshot.error.toString());
              //     } else if (snapshot.hasData) {
              //       print(data.toString());
              //       int rowNumber = 0;
              //       return SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: DataTable(
              //             border: TableBorder.all(width: 1),
              //             columnSpacing: 30,
              //             columns: [
              //               DataColumn(label: Text('م')),
              //               DataColumn(
              //                   label: Center(
              //                 child: Container(
              //                   child: Text(
              //                     'المحكمة',
              //                     textAlign: TextAlign.center,
              //                   ),
              //                 ),
              //               )),
              //               DataColumn(label: Text('الجلسة القادمة')),
              //               DataColumn(label: Text('رقم الدعوة')),
              //             ],
              //             rows: snapshot.data!.map((data) {
              //               rowNumber++;
              //               return DataRow(cells: [
              //                 DataCell(Text("${rowNumber}")), //TODO
              //                 DataCell(Text("${data.courtName.toString()} ")),
              //                 DataCell(Text(
              //                     formatDate(data.nextHearingDate.toString()))),
              //                 DataCell(
              //                   Text(
              //                       " ${data.judicialYear.toString()}/${data.serial.toString()}"),
              //                 ),
              //               ]);
              //             }).toList(),
              //             showBottomBorder: true,
              //           ),
              //         ),
              //       );
              //     } else {
              //       return Text("No data available.");
              //     }
              //   },
              // ),