import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'package:shart/features/chats/data/models/chat_user.dart';
import 'package:shart/features/chats/presentation/chat_screen.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/shared_screens/notifications/logic/notification_cubit.dart';
import 'package:shart/shared_screens/notifications/presentation/screens/notification_screen.dart';
import 'core/routing/navigation_services.dart';
import 'core/routing/routes.dart';
import 'features/chats/logic/chat_cubit.dart';
import 'features/services.dart';
class NotificationsFCM {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationsFCM(BuildContext context) {
    configLocalNotification();
    registerNotification(context);
    _createNotificationChannel('shart', 'shart', 'shart');
  }

  void registerNotification(BuildContext context) async {
    debugPrint('FCM registerNotification');
    await firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      message.data.forEach((String key, value) {
        debugPrint('fcm message $key -> $value');
      });
      RemoteNotification notification = message.notification!;
      Map<String, dynamic> data = message.data;

      print('testsdfsfd = ${ChatCubit.get().chatRoom??'null'}');
      if(ChatCubit.get().chatRoom != message.notification!.title){
        showNotification('${notification.title}', '${notification.body}', data,);
      }

      AuthCubit.get(context).token.isNotEmpty?
          NotificationCubit.get(context).getNotification(10, 'user', context):
          NotificationCubit.get(context).getNotification(10, 'provider', context);
      // NavigationService.push(NavigationService.navigationKey.currentContext!,
      //     Routes.notificationsScreen);
    });

    Stream<RemoteMessage> stream = FirebaseMessaging.onMessageOpenedApp;
    stream.listen((RemoteMessage event) async {
      debugPrint("clicked");
      // debugPrint(event.data.toString());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)async {
      debugPrint('A new onMessageOpenedApp event was published!');
      debugPrint('Message data: ${message.data.values}');
      debugPrint("${message.data["id"]}GGgGGgGGGgGGgGGgG");
      // final Map<String, dynamic> notificationInfo = json.decode(message);
      // final String propertyId = notificationInfo['id'];
      //TODO handle notification redirect
      if (message.notification != null) {
        debugPrint('${message.notification!.title!}999uu99${message.notification!.title!.substring(0,5)}9999999999999999999999999999');
        debugPrint('${message.notification!.body!}888888888888888');
        // if (message.notification != null && message.notification!.title != null) {
        //   if(message.notification!.title=='New Order'){
        //     print('yes New Order');
        //     NavigationService.push(NavigationService.navigationKey.currentContext!, Routes.providerOrders);
        //   }
        //   else if(message.notification!.title!.substring(0,5)=='Order'){
        //     print('yes =-== Order');
        //     // Navigator.of(context).pushNamed(Routes.orders);
        //       // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
        //       //     NotificationScreen(type: 'user')));
        //
        //   }        } else {
        //   // قد تكون القيمة null، فقم بمعالجة الحالة بشكل مناسب
        // }

      //   NavigationManager.push(Routes.orders);

      //   var x =await CacheHelper.getDate(key: 'token');
      //   // x!=null?
      //   // NavigationManager.push(Routes.orders):
      //   // NavigationManager.push(Routes.providerOrders);
      //   x!=null?
      //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
      //       NotificationScreen(type: 'user'))):
      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
      //       NotificationScreen(type: 'provider')));
        // NavigationService.push(NavigationService.navigationKey.currentContext!, Routes.orders);


         }

       //yehya

      // Perform desired action when the user clicks on the notification
      debugPrint('A end onMessageOpenedApp event was published!');

    });
    // FirebaseMessaging.onBackgroundMessage(BackgroundNotificationHandler.handleNotification);

     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // FirebaseMessaging.onBackgroundMessage((message) async =>
    //     NavigationService.push(NavigationService.navigationKey.currentContext!,
    //         Routes.orders));

    // RemoteMessage? remoteMessage = await firebaseMessaging.getInitialMessage();
    //
    // if (remoteMessage!.contentAvailable) {
    //   NavigationService.push(NavigationService.navigationKey.currentContext!,
    //       Routes.orders);
    // }
    firebaseMessaging.subscribeToTopic('shart');
    firebaseMessaging.getToken().then((String? token) {
      debugPrint('FCM registerNotification token $token');
      saveFCM(token!);
    });
    debugPrint('A /////////end o***********nMessageOpenedApp event was published!');
  }

  // void _handleMessage(RemoteMessage message) {
  //   kEcho('_handleMessage');
  //   String? navigator = message.data['navigator'];
  //   String? id = message.data['id'];
  //   if (navigator == 'product' && id != null) {
  //     try {
  //       int idAsInt = int.parse(id);
  //       ProductModel productModel = ProductModel(productId: idAsInt, price: 0);
  //       Get.toNamed(
  //         Routes.PRODUCT,
  //         arguments: productModel,
  //         parameters: {"wholesalerId": '1'},
  //       );
  //     } catch (e) {
  //       if (kDebugMode) showSnackBar(title: Strings().notification, message: '$e');
  //     }
  //   }
  // }

  void configLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      // onDidReceiveBackgroundNotificationResponse: (NotificationResponse details) {
      //   // kEcho(details.payload!);
      //   print('=========5655556==${details.toString()}====');
      //
      // },
    );
  }

  Future<void> onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null && payload.isNotEmpty) {
      print('Received payload: $payload');
      try {
        final Map<String, dynamic> notificationInfo = json.decode(payload);

        // Safely retrieve the documentId and messageBody
        final String? documentId = notificationInfo['documentId'];
        final String? messageBody = notificationInfo['body'];

        if (messageBody != null) {
          print('Message Body: $messageBody');
        } else {
          print('No message body in payload');
        }
        var token = await CacheHelper.getDate(key: 'token');
        if (documentId != null) {
          BuildContext context =NavigationManager.navigationKey.currentContext!;
          ChatUser chatUser =ChatUser(image: '', about: '', name: '', createdAt: '', isOnline: true, id: documentId, lastActive: '', phone: '', pushToken: '');
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ChatScreen(receiverData: chatUser, isUser: token!=null?true:false)));
        } else {
          print('No document ID in payload');

          if (token != null) {
            NavigationManager.push(Routes.orders);
          } else {
            NavigationManager.push(Routes.providerOrders);
          }
        }
      } catch (e) {
        print('Error parsing payload or fetching document: $e');
        // Handle parsing or network error
      }
    } else {
      print('Notification payload is null or empty');
      // Handle the case where payload is null or empty
    }
  }


  Future<void> _createNotificationChannel(
      String id, String name, String description) async {
    debugPrint('create channel');
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      id,
      name,
    );
    debugPrint('create channdddkkkkkkkkkkkkkkkkkkkk=========dddddddddddddddddel');

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

  }

  void _handleMessage(RemoteMessage message) async {
    debugPrint('FCM Message Data: ${message.data}');
    debugPrint('FCM Message Notification: ${message.notification}');
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    _handleMessage(message);
  }

  void showNotification(
      String title, String message, Map<String, dynamic> payLoad) async {
    debugPrint('FCM showNotification title $title');
    debugPrint('FCM showNotification message $message');
    debugPrint('FCM showNotification payLoad $payLoad');
    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'default_notification_channel_id',
        'shart',
        playSound: true,
        enableVibration: true,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'logo',
      // actions: [
      //   AndroidNotificationAction(
      //       "click_action", "FLUTTER_NOTIFICATION_CLICK")
      // ]
    );

    DarwinNotificationDetails iOSPlatformChannelSpecifics =
    const DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: jsonEncode(payLoad),
    );
  }

  void saveFCM(String fcm) async {
    debugPrint('FCM saveFCM $fcm');
    //ApiConsumer apiConsumer = getIt<ApiConsumer>();
    // try {
    //   await apiConsumer.get(
    //       url: EndPoints.getAppVersion, queryParameters: {'fcm_token': fcm});
    // } on Exception catch (e) {
    //   kEcho('FCM saveFCM error $e');
    // }
  }
}
