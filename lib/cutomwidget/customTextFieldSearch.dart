import 'package:flutter/material.dart';

class CustomTextFieldSearch extends StatelessWidget {
  const CustomTextFieldSearch({
    super.key,
    required TextEditingController controllerCaseNumber,
    required this.labelText,
  }) : _controllerCaseNumber = controllerCaseNumber;

  final TextEditingController _controllerCaseNumber;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _controllerCaseNumber,
        decoration: InputDecoration(
          icon: Icon(Icons.account_balance_outlined),
          border: UnderlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
