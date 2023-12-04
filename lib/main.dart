import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/Provider/travelprovider.dart';
import 'package:escapingplan/screen/MessagePage.dart';
import 'package:escapingplan/screen/splashscreen2.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/sharedpreferance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';

double? latitude = 0.0;
double? longitude = 0.0;
BuildContext? appContext;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("background");
  // RemoteNotification? notification = message.notification;
  // var title =  notification?.title.toString();
  // var body = notification?.body.toString();
  // AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       payload: {
  //
  //         "name": "FlutterCampus", "route": "/chat"
  //       },
  //       id: Random().nextInt(100000),
  //       channelKey: 'alerts',
  //       title: title,
  //       icon: body == "Photo" ? "assets/car.png":"assets/cloud.png",
  //       bigPicture: 'assets/logo.png',
  //       body: body,
  //     ));
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  }
  else{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  AwesomeNotifications().initialize(
      'resource://drawable/logo.png', // icon for your app notification
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          onlyAlertOnce: true,

          groupAlertBehavior: GroupAlertBehavior.Children,
          defaultPrivacy: NotificationPrivacy.Private,
          // defaultColor: ColorsResources.primaryColor,
          // ledColor: ColorsResources.primaryColor,
          channelShowBadge: true,
          vibrationPattern: mediumVibrationPattern,
          enableVibration: true,
          // icon: 'assets/logo.png',
          importance: NotificationImportance.High,
        ),
      ]);
  // getdata1(index);
  FirebaseMessaging messaging= FirebaseMessaging.instance;
  await  messaging.requestPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();

  }
  String? state1;
  getdata() async {
    // FirebaseMessaging.instance.getToken().then((value) {
    //   setState(() {
    //     token = value;
    //   });
    // });
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }
  // }
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => authprovider()),
          ChangeNotifierProvider(create: (context) => travelprovider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routes:  {

             '/chat': (context) => const MessagePage(),
            // Define more routes as needed
          },
          home:   const splashscreen2()
          // routes: {
          //   WeeklyScreen.routeName: (myCtx) => WeeklyScreen(),
          //   HourlyScreen.routeName: (myCtx) => HourlyScreen(),
          // },
        )
      );
    });
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (context) => authprovider()),
//           ChangeNotifierProvider(create: (context) => travelprovider()),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           routes:  {
//
//             '/chat': (context) => MessagePage(),
//             // Define more routes as needed
//           },
//           home: splashscreen2(),
//           // routes: {
//           //   WeeklyScreen.routeName: (myCtx) => WeeklyScreen(),
//           //   HourlyScreen.routeName: (myCtx) => HourlyScreen(),
//           // },
//         ),
//       );
//     });
//   }
//
// }
