// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static Future initialize() async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     AndroidInitializationSettings androidInitializationSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     InitializationSettings initializationSettings =
//     InitializationSettings(android: androidInitializationSettings);
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onSelectNotification: doSomething(),
//     );
//   }
//   static Future showNotification(RemoteMessage message) async {
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       "default_notification_channel_id",
//       "channel",
//       enableLights: true,
//       enableVibration: true,
//       priority: Priority.high,
//       importance: Importance.max,
//       largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
//       styleInformation: MediaStyleInformation(
//         htmlFormatContent: true,
//         htmlFormatTitle: true,
//       ),
//       playSound: true,
//     );
//     await _flutterLocalNotificationsPlugin.show(
//         message.data.hashCode,
//         message.data['title'],
//         message.data['body'],
//         NotificationDetails(
//           android: androidDetails,
//         ));
//   }
// }
