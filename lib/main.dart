import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:shart/core/shared_preference/shared_preference.dart';
import 'app.dart';
import 'features/common/intro/presentation/screens/choose_user_type_screen.dart';
import 'features/common/intro/presentation/screens/onboarding_screen.dart';
import 'features/common/splash/presentation/screens/splash_screen.dart';
import 'features/provider/bottom_nav/presentation/screens/bottom_nav.dart';
import 'features/user/bottom_nav/presentation/screens/bottom_nav_screen.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  var onBoarding = await CacheHelper.getDate(key: 'onBoarding');
  var type = await CacheHelper.getDate(key: 'type');
  var isLog = await CacheHelper.getDate(key: 'isLog');
  Widget widget;
  if (onBoarding != null) {
    if (isLog != null) {
      if(type == 'user'){
        widget =  UserBottomNavScreen();
      }
      else{
        widget =  ProviderBottomNavScreen();
      }
    }
    else {
      widget = ChooseUserTypeScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(DevicePreview(
      enabled: false,
      builder:(BuildContext context)=>MyApp(widget: widget,),
    ),
  );
}
