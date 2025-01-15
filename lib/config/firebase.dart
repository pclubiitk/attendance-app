// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hive/hive.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'localStorage.dart';
// import 'notification.dart';
// import 'firebase_options.dart';

// class FirebaseConfig {
//   static Future<void> initialize() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform
//     );
//   }

//   static void listenNotification() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     });
//   }

//   static Future<void> checkForInitialMessage() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//   }

//   static Future<PermissionStatus> _getNotificationsPermission() async {
//     var status = await Permission.notification.status;
//     if (!status.isGranted) {
//       final result = await Permission.notification.request();
//       return result;
//     } else {
//       return status;
//     }
//   }

//   static Future<void> registerNotification() async {
//     PermissionStatus status=await _getNotificationsPermission();
//     if(kDebugMode){
//       print(status);
//     }
//     var messaging = FirebaseMessaging.instance;
//     print("FCM TOKEN: ${await messaging.getToken()}");
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         LocalStorage.addNotification(message.notification!.toMap());
//         NotificationConfig.showNotification(message);
//       });
//     }
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//   @pragma('vm:entry-point')
//   static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     Firebase.initializeApp();
//     await Storage.initialize();
//     if(Hive.box("localStorage").isOpen){
//       LocalStorage.addNotification(message.notification!.toMap());
//     }
//   }
// }
