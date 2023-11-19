import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../providerclasses.dart/providerlanguage.dart';

void createAwesome(
    BuildContext context, LanguageProvider languageProvider) async {
  AwesomeDialog(
          title: languageProvider.getCurrentData("errorEnterNet"),
          context: context,
          body: Text(
            languageProvider.getCurrentData("requireNetWorkMes"),
          ),
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          btnOkColor: Colors.amber,
          btnOkOnPress: () {})
      .show();
}
