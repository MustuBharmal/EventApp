// import 'package:event_app/screens/notification_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../main.dart';
//
// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//
//     final fCMToken = await _firebaseMessaging.getToken();
//
//     print('Token: $fCMToken');
//     initPushNotification();
//   }
//   void listenFCM() async {
//     // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     //   RemoteNotification? notification = message.notification;
//     //   AndroidNotification? android = message.notification?.android;
//     //   if (notification != null && android != null && !kIsWeb) {
//     //     flutterLocalNotificationsPlugin.show(
//     //       notification.hashCode,
//     //       notification.title,
//     //       notification.body,
//     //       NotificationDetails(
//     //         android: AndroidNotificationDetails(
//     //           channel.id,
//     //           channel.name,
//     //           // TODO add a proper drawable resource to android, for now using
//     //           //      one that already exists in example app.
//     //           icon: 'launch_background',
//     //         ),
//     //       ),
//     //     );
//     //   }
//     // });
//   }
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     navigatorKey.currentState?.pushNamed(
//       NotificationsScreen.routeName,
//       arguments: message,
//     );
//   }
//
//   Future initPushNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
//
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }
