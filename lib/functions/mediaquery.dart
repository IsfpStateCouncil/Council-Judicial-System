import 'package:flutter/material.dart';

double GetSizePage(BuildContext context, int diemestion, int precentage,String namePage) {
  try {
    double size;
    if (MediaQuery.of(context).orientation.toString() ==
        "Orientation.landscape" && namePage =="home") {
      if (diemestion == 1) //width
      {
        size = (MediaQuery.of(context).size.width * precentage) / 100;
        return size;
      } else if (diemestion == 2) //hieght
      {
        size = (MediaQuery.of(context).size.height * precentage*2) / 100;
        return size;
      } else
        return 1;
    } else {
      if (diemestion == 1) //width
      {
        size = (MediaQuery.of(context).size.width * precentage) / 100;
        return size;
      } else if (diemestion == 2) //hieght
      {
        size = (MediaQuery.of(context).size.height * precentage) / 100;
        return size;
      } else
        return 1;
    }
  } catch (e) {
    print(e.toString());
    return 1;
  }
}
