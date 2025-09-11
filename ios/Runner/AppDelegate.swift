import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
      //      UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(/* Your Desired Interval for Background Tasks */))
      //      if #available(iOS 10.0, *) {
      //              // For iOS 10 display notification (sent via APNS)
      //              UNUserNotificationCenter.current().delegate = self
      //              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      //              UNUserNotificationCenter.current().requestAuthorization(
      //                      options: authOptions,
      //                      completionHandler: {_, _ in })
      //          } else {
      //              let settings: UIUserNotificationSettings =
      //              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      //              application.registerUserNotificationSettings(settings)
      //          }
      //      application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication,
                              didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        Messaging.messaging().apnsToken = deviceToken
        print("IOS_TOKEN_X: \(deviceToken)")
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}
