import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../auth/logic/auth_cubit.dart';

Widget buildProfileItemWidget(
    { String? iconPath,
    required Function function,
    bool? hasArrowButton,
    bool? lang,
      context,
    required String text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: InkWell(
      onTap: () {
        function();
      },
      child: Row(
        children: <Widget>[
          iconPath !=null? SvgPicture.asset(iconPath):Image.asset('assets/images/privacy.png'),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeightManager.regular,
                fontFamily: FontConstants.lateefFont,
                color: text == 'حذف الحساب' ? Colors.red : blackColor),
          ),
          const Spacer(),
          lang==true?
         BlocConsumer<AuthCubit,AuthState>(builder: (BuildContext context,AuthState state){
           return  Container(
             width: 100.w,
             child: Row(
               children: [
                 Container(
                   height:36.h ,
                   width: 42.w,
                   decoration: BoxDecoration(
                       color: AuthCubit.get(context).localeLanguage==Locale('ar')?Color(0xffFFDF58):Colors.transparent,
                       border: Border.all(color:AuthCubit.get(context).localeLanguage==Locale('en')? Color(0xff100E0D):Colors.transparent),
                       borderRadius: BorderRadius.all(Radius.circular(10.sp))
                   ),
                   child: Center(child: FittedBox(
                     child: Text('AR',
                       style: TextStyle(
                           fontFamily: FontConstants.lateefFont,
                           fontWeight: FontWeight.w500,
                           fontSize: 20.sp
                       ),
                     ),
                   )),

                 ),
                 SizedBox(width: 9.w,),
                 Container(
                   height:36.h ,
                   width: 42.w,
                   decoration: BoxDecoration(
                       color: AuthCubit.get(context).localeLanguage==Locale('en')?Color(0xffFFDF58):Colors.transparent,
                       border: Border.all(color:AuthCubit.get(context).localeLanguage==Locale('ar')? Color(0xff100E0D):Colors.transparent),
                       borderRadius: BorderRadius.all(Radius.circular(10.sp))
                   ),
                   child: Center(child: FittedBox(
                     child: Text('En',
                       style: TextStyle(
                           fontFamily: FontConstants.lateefFont,
                           fontWeight: FontWeight.w500,
                           fontSize: 20.sp
                       ),
                     ),
                   )),

                 ),
               ],
             ),
           );
         }, listener: (BuildContext context,AuthState state){}):SizedBox.shrink(),
          if (hasArrowButton != false)Icon(Icons.arrow_forward_ios, color: Colors.grey,)
          // SvgPicture.asset(IconsManager.profileArrow)
        ],
      ),
    ),
  );
}
