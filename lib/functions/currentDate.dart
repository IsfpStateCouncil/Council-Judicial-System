import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> dataWithCurrentLanguage(String date, String language) async {
  if (date != null) {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //String? language = sharedPreferences.getString("language");
    await Jiffy.setLocale(language);
    Jiffy jiffyDate = Jiffy.parseFromDateTime(DateTime.parse(date));

    // Use DateFormat from intl for date formatting
    DateFormat dateFormat = DateFormat.yMMMMEEEEd(language).add_jm();
    String arabicDate = dateFormat.format(jiffyDate.dateTime);
    return arabicDate;
  } else {
    return "";
  }
}
