import 'package:flutter/material.dart';

double getSizePage(
    BuildContext context, int dimestion, int precentage, String namePage) {
  try {
    double size;
    if (MediaQuery.of(context).orientation.toString() ==
        "Orientation.landscape" && namePage =="home_screen") {
      if (dimestion == 1) //width
      {
        size = (MediaQuery.of(context).size.width * precentage) / 100;
        return size;
      } else if (dimestion == 2) //hieght
      {
        size = (MediaQuery.of(context).size.height * precentage * 2) / 100;
        return size;
      } else {
        return 1;
      }
    } else {
      if (dimestion == 1) //width
      {
        size = (MediaQuery.of(context).size.width * precentage) / 100;
        return size;
      } else if (dimestion == 2) //hieght
      {
        size = (MediaQuery.of(context).size.height * precentage) / 100;
        return size;
      } else {
        return 1;
      }
    }
  } catch (e) {
    return 1;
  }
}
