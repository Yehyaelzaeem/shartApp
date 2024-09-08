// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../../features/chats/logic/chat_cubit.dart';
// import '../../features/user/auth/logic/auth_cubit.dart';
// import '../../shared_screens/notifications/logic/notification_cubit.dart';
// import '../routing/navigation_services.dart';
//
//
// class NotificationService {
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/launcher_icon');
//
//     const DarwinInitializationSettings initializationSettingsIOS =
//     DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     );
//
//     // Request permissions for iOS
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // Configure FCM
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       AuthCubit.get(NavigationManager.navigationKey.currentContext!).token.isNotEmpty?
//       NotificationCubit.get(NavigationManager.navigationKey.currentContext!).getNotification(10, 'user', NavigationManager.navigationKey.currentContext!):
//       NotificationCubit.get(NavigationManager.navigationKey.currentContext!).getNotification(10, 'provider', NavigationManager.navigationKey.currentContext!);
//       if(ChatCubit.get().chatRoom!=message.notification!.title){
//         _showNotification(message);
//       }
//     });
//   }
//
//   Future<void> _showNotification(RemoteMessage message) async {
//
//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//         'your_channel_id',
//         'your_channel_name',
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: false,
//       );
//
//       const DarwinNotificationDetails iOSPlatformChannelSpecifics =
//       DarwinNotificationDetails();
//
//       const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics,
//       );
//
//       await _flutterLocalNotificationsPlugin.show(
//         0, // Notification ID
//         message.notification?.title,
//         message.notification?.body,
//         platformChannelSpecifics,
//         payload: 'Default_Sound',
//       );
//
//   }
//
//   // Handle notification tapped logic here
//   void onDidReceiveNotificationResponse(NotificationResponse response) async {
//     // Handle your logic here when a notification is tapped
//   }
//
//   // Handle received local notification for iOS
//   static void onDidReceiveLocalNotification(
//       int id,
//       String? title,
//       String? body,
//       String? payload,
//       ) async {
//     // Handle your logic here when a local notification is received on iOS
//   }
// }
