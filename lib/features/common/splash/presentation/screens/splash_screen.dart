import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../../../provider/bottom_nav/presentation/screens/bottom_nav.dart';
import '../../../../user/bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../../../intro/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer(Duration(seconds: 3), () {
      _navigation();
    });
  }

   _navigation()async{

     var onBoarding = await CacheHelper.getDate(key: 'onBoarding');
     var type = await CacheHelper.getDate(key: 'type');
     var isLog = await CacheHelper.getDate(key: 'isLog');
     var provider = await CacheHelper.getDate(key: 'providerToken');

     Widget widget;
     if (onBoarding != null) {
       // if (isLog != null) {
       //   // if(type == 'user'){
       //   //   widget =  UserBottomNavScreen();
       //   // }
       //   // else{
       //   //   widget =  ProviderBottomNavScreen();
       //   // }
       // }
       // else {
       //   widget = ChooseUserTypeScreen();
       // }
       if(provider==null){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserBottomNavScreen()));
       }
       else{
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProviderBottomNavScreen()));
       }
     }
     else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen()));

       widget = const OnBoardingScreen();
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        ImagesManager.splashImg,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
