import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("start 2");
  print('Title:  ${message.notification?.title}');
  print('Body:  ${message.notification?.body}');
  print('Payload:  ${message.data}');
  print("end fun 2");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    var firebaseApp =
        await Firebase.app().options; // Get the default app instance
    //var options = firebaseApp.options.asMap();
    //String projectId = options["projectId"];
    print('Firebase Project ID: $firebaseApp');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    print("end fun 1");
  }
}
