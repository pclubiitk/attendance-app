// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// class NotificationConfig {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'pclub-notification', 
//     'pclub-ui-notification', 
//     description: 'This channel is used for important notifications.',
//     importance: Importance.max,
//   );
//   static Future initialize(context) async {
//     var androidInitialize =
//         const AndroidInitializationSettings('mipmap/ic_noti');
//     var initializationsSettings =
//         InitializationSettings(android: androidInitialize);
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//   }

//   static Future showNotification(RemoteMessage message) async {
//     late AndroidNotificationDetails androidPlatformChannelSpecifics;
//     if(message.notification!.android!.imageUrl!=null && message.notification!.android!.imageUrl!=""){
//       final http.Response response = await http.get(Uri.parse(message.notification!.android!.imageUrl!));
//       BigPictureStyleInformation bigPictureStyleInformation =
//       BigPictureStyleInformation(
//         ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
//         largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
//       );
//       androidPlatformChannelSpecifics = AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           playSound: true,
//           icon: "mipmap/ic_noti",
//           importance: Importance.max,
//           priority: Priority.max,
//           styleInformation: bigPictureStyleInformation,
//           largeIcon: ByteArrayAndroidBitmap.fromBase64String(
//               base64Encode(response.bodyBytes))
//       );
//     }else{
//       androidPlatformChannelSpecifics = AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           playSound: true,
//           icon: "mipmap/ic_noti",
//           importance: Importance.max,
//           priority: Priority.max
//       );
//     }

//     var not = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0,message.notification!.title , message.notification!.body, not,
//         payload: jsonEncode(message.data));
//   }
// }
