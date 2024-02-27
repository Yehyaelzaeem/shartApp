import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';

import 'core/routing/navigation_services.dart';
import 'core/routing/routes.dart';
import 'features/services.dart';
class NotificationsFCM {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationsFCM() {
    configLocalNotification();
    registerNotification();
    _createNotificationChannel('shart', 'shart', 'shart');
  }

  void registerNotification() async {
    debugPrint('FCM registerNotification');
    await firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      message.data.forEach((String key, value) {
        debugPrint('fcm message $key -> $value');

      });
      RemoteNotification notification = message.notification!;
      Map<String, dynamic> data = message.data;
      // AndroidNotification android = message.notification!.android!;
      showNotification('${notification.title}', '${notification.body}', data);
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
        debugPrint('${message.notification!.title!}999999999999999999999999999999999');
        debugPrint('${message.notification!.body!}888888888888888');
        debugPrint('${message.notification!.bodyLocKey!}99999999555559999999999999999999999999');
        debugPrint('${message.notification!.bodyLocArgs!}ffgfhfghgfhfhfghgh');
        debugPrint('${message.notification!.apple!}99999999999999988888999999999999999999');
      //   if(message.notification!.title=='New Order'){
      //     NavigationService.push(NavigationService.navigationKey.currentContext!, Routes.providerOrders);
      //   }
      //   else if(message.notification!.title!.substring(0,4)=='Order'){
      //     NavigationService.push(NavigationService.navigationKey.currentContext!, Routes.orders);
      //   }
      //   NavigationManager.push(Routes.orders);

        var x =await CacheHelper.getDate(key: 'token');
        x!=null?
        NavigationManager.push(Routes.orders):
        NavigationManager.push(Routes.providerOrders);
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
      // onDidReceiveBackgroundNotificationResponse: (details) =>
      //     kEcho("gsddfgsdfadadsg"),
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      // onDidReceiveBackgroundNotificationResponse: (NotificationResponse details) {
      //   // kEcho(details.payload!);
      //   print('=========5655556==${details.toString()}====');
      //
      // },
    );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('asd///${notificationResponse.payload.toString()}/////////');
      try {
        final Map<String, dynamic> notificationInfo = json.decode(notificationResponse.payload!);
        print('222222222${notificationInfo.toString()}22222222');
        // استخدم البيانات المحوّلة بنجاح هنا
      } catch (e) {
        print('3333333');
        // تعامل مع الخطأ هنا
      }
    } else {
      print('4444444444444');
      // قم بمعالجة الحالة التي تكون فيها قيمة payload فارغة
    }
    if (notificationResponse.payload != null) {
      debugPrint(payload!);
      debugPrint('test==id========${notificationResponse.id}');
      debugPrint('test==id====56====${notificationResponse.actionId}');
      final Map<String, dynamic> notificationInfo = json.decode(notificationResponse.payload!);
      final dynamic propertyId = notificationInfo['order_id'];
      print('id ===== : ${propertyId}');
      var x =await CacheHelper.getDate(key: 'token');
      x!=null?
      NavigationManager.push(Routes.orders):
      NavigationManager.push(Routes.providerOrders);


      // NavigationService.push(NavigationService.navigationKey.currentContext!,
      //
      //    Routes.notificationsScreen);
      if (propertyId != null) {
        // Handle the notification response with valid data
      }
      else {
        // Handle the case where the payload is empty or null
        debugPrint('Notification payload is empty or null');
      }
    }
  }

  Future<void> _createNotificationChannel(
      String id, String name, String description) async {
    debugPrint('create channel');
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      name,
    );
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
    debugPrint('FCM showNotification message $message');
    debugPrint('FCM showNotification payLoad $payLoad');
    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'default_notification_channel_id',
        'shart',
        playSound: true,
        enableVibration: true,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'logo2',
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
