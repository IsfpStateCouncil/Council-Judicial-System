import 'dart:ui';

class StaticData {
  static const String urlConnectionConst =
      'http://10.0.65.164:7001/EWebService/rest/'; //10.0.15.117 10.9.100.225:7011
  static const String loginConst = "${urlConnectionConst}core/Login";
  static const String notificationConst =
      'notificationsList/getAllUnreadNotification';
  static const String editNotifictaionConst =
      'notificationsList/EditNotifictaions';
  static const String findAllCaseStatusConst = "cases/findAllCaseStatus";
  static const String searchCasesDataConst = "cases/searchCasesData";
  static const String getAllJudgueYears = "cases/getAllJudgueYears";
  static const String searchForNotificationsListData =
      "notificationsList/searchForNotificationsListData";
  static const String getAllNotificationCategory =
      "notificationsList/getAllNotificationCategory";
////////////////////////// textDirection /////////////////////
  static const arabicTextDirection = TextDirection.rtl;
  static const englishTextDirection = TextDirection.ltr;
////////////////////   Images path  //////////////////////////////////
  static const String imageLogo = 'assets/images/logo.PNG';
  static const String imageDrawer =
      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg';
  static const String drawerImage = 'assets/images/drawerImage.png';
  static const Color button = Color(0xFFD5AA6D);
  static const Color font = Color(0xFF200908);
  static const Color appBarColor = Color(0xFF200908);
  static const Color backgroundColors = Color(0xFFfcfcfc);
  //////////////////// font family ///////////////////
  static String fontFamily = "Cairo";
}
