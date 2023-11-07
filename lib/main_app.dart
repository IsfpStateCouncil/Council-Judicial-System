
///////// to solve problem Error when user need close app and reopen it no need rewrite userName and Password 



// import 'package:flutter/material.dart';
// import 'package:login_flutter/providerclasses.dart/controllerNotification.dart';
// import 'package:login_flutter/providerclasses.dart/provicerdatatablesearch.dart';
// import 'package:login_flutter/providerclasses.dart/providerNotificationAll.dart';
// import 'package:login_flutter/providerclasses.dart/providerlanguage.dart';
// import 'package:login_flutter/routes.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//  final SharedPreferences prefs = await SharedPreferences.getInstance();

//   @override
//   Widget build(BuildContext context) {
//     print("in widgit");
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//             create: (context) => ProviderNotificationModel()),
//         ChangeNotifierProvider<LanguageProvider>(
//             create: (context) => LanguageProvider()),
//         ChangeNotifierProvider<ProviderDataTableSearch>(
//             create: (context) => ProviderDataTableSearch()),
//         ChangeNotifierProvider(
//             create: (context) => ProviderNotificationAllModel()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData.from(
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: Color.fromARGB(255, 241, 243, 249),
//           ),
//         ),
//         // initialRoute: await user_exist() == 0 ? '/login' : '/',
//         onGenerateRoute: MyRoutes.generateRoute,
//         //home: NotificationPage(), //user_exist() == 0 ? Login() : Home(),
//       ),
//     );
//   }
// }
