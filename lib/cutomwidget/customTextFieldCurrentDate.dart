import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextFieldCurrenDate extends StatelessWidget {
  const CustomTextFieldCurrenDate({
    super.key,
    required TextEditingController controllerFromDate,
    required this.lableString,
  }) : _controllerFromDate = controllerFromDate;

  final TextEditingController _controllerFromDate;
  final String lableString;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _controllerFromDate, //editing controller of this TextField
        decoration: InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: lableString //"من تاريخ" //label text of field
            ),
        readOnly: true, // when true user cannot edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), //get today's date
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));
          if (pickedDate != null) {
            print(
                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
            String formattedDate = DateFormat('dd-MM-yyyy').format(
                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
            print(
                formattedDate); //formatted date output using intl package =>  2022-07-04
            //You can format date as per your need

            _controllerFromDate.text =
                formattedDate; //set foratted date to TextField value.
          } else {
            print("Date is not selected");
          }
          //when click we have to show the datepicker
        });
  }
}
