import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

String arabicTime(BuildContext context, String date) {
  Jiffy.locale("ar");
  String arabicDate = Jiffy(date).yMMMMEEEEdjm;
  print(Jiffy(date).yMMMMEEEEdjm);
  return arabicDate;
}
