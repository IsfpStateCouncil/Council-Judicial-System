import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String? language;
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
      "logout": "تسجيل الخروج"
    }
  };
  Map<String, dynamic> languageDataEn = {
    'en': {1: "hellow"}
  };
  void changelanguage(String type) {
    language = type;
    notifyListeners();
  }

  String getCurrentData(String key) {
    print(language);
    if (language == "en") {
      return languageDataEn['en'][key];
    } else {
      return languageDataAr['ar'][key];
    }
  }
}
