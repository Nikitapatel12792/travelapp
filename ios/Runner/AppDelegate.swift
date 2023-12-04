import UIKit
import Flutter
import GoogleMaps
// import Firebase
// import FirebaseMessaging
// import awesome_notifications
// import shared_preferences_ios

// import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?

  ) -> Bool {
//   FirebaseApp.configure()
   GMSServices.provideAPIKey("AIzaSyAcdWHc6N80RTNJedhbhKBsikB1CcAuOGw")
    GeneratedPluginRegistrant.register(with: self)
//         SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
//                   SwiftAwesomeNotificationsPlugin.register(
//                     with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
//                   FLTSharedPreferencesPlugin.register(
//                     with: registry.registrar(forPlugin: "io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin")!)
//               }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
//   override func application(_ application: UIApplication,
//     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//
//      Messaging.messaging().apnsToken = deviceToken
//      print("Token: \(deviceToken)")
//      super.application(application,
//      didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
//    }
}
