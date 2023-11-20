import 'package:jiffy/jiffy.dart';

Future<String> arabicTime(String date) async {
  await Jiffy.locale("ar");
  String? arabicDate = Jiffy(date).yMMMMEEEEdjm;
  return arabicDate;
}
