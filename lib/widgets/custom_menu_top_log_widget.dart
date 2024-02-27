import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../core/resources/assets_menager.dart';
import '../core/routing/navigation_services.dart';
import '../core/routing/routes.dart';
import '../shared_screens/notifications/presentation/screens/notification_screen.dart';
import 'package:lottie/lottie.dart';

class CustomTopRowLogo extends StatelessWidget {
  const CustomTopRowLogo({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {},
        builder: (BuildContext context, AuthState state) {
          return Row(
            children: <Widget>[
              SizedBox(width: 155.w,),
             Image.asset(
                ImagesManager.logoCircle,
              ),
              Spacer(),
              type=='user'?
              AuthCubit.get(context).token.isNotEmpty?
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>NotificationScreen(type: type,)));
                },
                child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10.w),
                    child:
                  // SvgPicture.asset('assets/images/svg/notification.svg')
                  Lottie.asset('assets/json/notification.json',
                      width: 33.sp, height: 33.sp),
                ),
              ) :
              SizedBox.shrink():
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>NotificationScreen(type: type,)));
                 },
                child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10.w),
                    child:
                    // SvgPicture.asset('assets/images/svg/notification.svg'),
                    Lottie.asset('assets/json/notification.json',
                        width: 33.sp, height: 33.sp),

                ),
              ),
              SizedBox(width: 10.w,),

            ],
          );
        },
      );
  }
}
