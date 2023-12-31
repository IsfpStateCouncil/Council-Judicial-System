import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String? language;
  Locale? locale;
  Map<String, dynamic> languageDataAr = {
    'ar': {
      //////////////// Home() ////////////
      "requestedOrder": "طلبات مقبوله",
      "sendedOrder": "طلبات مرسلة",
      "sessions": "جلسات",
      "suits": "الدعاوى",
      "fines": "غرمات",
      "adjurndedSessions": "جلسات مؤجلة",
      "EgyptianStateCouncil": "مجلس الدولة المصري",
      "errorEnterNet": "خطاء اتصال الانترنت",
      "requireNetWorkMes": "يجيب توفير اتصال بالانترنت",
      //////////////// login()   /////////////////
      "login": "تسجيل الدخول",
      "userName": "اسم المستخدم",
      "plzEnterUserName": "برجاء ادخال اسم المستخدم",
      "password": "كلمة السر",
      "plzEnterPassword": "برجاء ادخال كلمة السر",
      "squance": "رقم المسلسل",
      //////////////////// Navbar()//////////////////
      "mainPage": "الشاشة الرئيسية",
      "allNotification": "الإشعارات كاملة",
      "order": "الطلبات",
      "fetchData": "fetchData",
      "deposit": "الأيداع",
      "sessionsTime": "مواعيد الجلسات",
      "advancedSearch": "البحث المتقدم",
      "logout": "تسجيل الخروج",
      ///////////////////DataTAbleSearch()////////
      "year": "السنة",
      "casenumber": "رقم الدعوى",
      "casestatus": "حالة الدعوي",
      "judicialyear": "العام القضائي",
      "search": "بحث",
      "thecourt": "المحكمة",
      "thenextsession": "الجلسة القادمة",
      "datefrom": "من تاريخ",
      "dateTo": "إلي تاريخ",
      "errorinusernameorpassword": "خطأ في اسم المستخدم او كلمة السر",
      "texthintsearch": "بحث .....",
    }
  };
  Map<String, dynamic> languageDataEn = {
    'en': {
      //////////////// Home() ////////////
      "requestedOrder": "Requested Order",
      "sendedOrder": "Sended Order",
      "sessions": "Sessions",
      "suits": "Suits",
      "fines": "Fines",
      "adjurndedSessions": "Adjurnded Sessions",
      "EgyptianStateCouncil": "Egyptian State Council",
      "errorEnterNet": "Error In Enternet",
      "requireNetWorkMes": "Provides internet connectivity",
      //////////////// login()   /////////////////
      "login": "Login",
      "userName": "User Name",
      "plzEnterUserName": "Please Enter The Username",
      "password": "Password",
      "plzEnterPassword": "Please Enter The Password",
      "squance": "Serial Number",
      //////////////////// Navbar()//////////////////
      "mainPage": "Home Screen",
      "allNotification": "All Notifications",
      "order": "Orders",
      "fetchData": "FetchData",
      "deposit": "Deposit",
      "sessionsTime": "Session Schedules",
      "advancedSearch": "Advanced Search",
      "logout": "Log out",
      ///////////////////DataTAbleSearch()////////
      "year": "Year",
      "casenumber": "Case Number",
      "casestatus": "Case Status",
      "judicialyear": "Judicial Year",
      "search": "Search",
      "thecourt": "The Court",
      "thenextsession": "The Next Session",
      "datefrom": "Date From",
      "dateTo": "Date To",
      "errorinusernameorpassword": "Error In Username Or Password",
      "texthintsearch": "Search .....",
    }
  };
  void changelanguage(String? type) {
    language = type;
    //notifyListeners();
  }

  getCurrentData(String key, BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale.toLanguageTag());
    if (myLocale.toLanguageTag() == "en") {
      return languageDataEn['en'][key];
    } else {
      return languageDataAr['ar'][key];
    }
  }
}
