import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> dataWithCurrentLanguage(String date) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? language = sharedPreferences.getString("language");
  await Jiffy.locale(language);
  String? arabicDate = Jiffy(date).yMMMMEEEEdjm;
  return arabicDate;
}
