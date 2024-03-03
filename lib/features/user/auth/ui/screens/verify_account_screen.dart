import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../widgets/custom_button.dart';

class VerifyAccountScreen extends StatelessWidget {
  final String otpCode;
  final String? type;
  const VerifyAccountScreen({super.key, required this.otpCode, this.type});

  @override
  Widget build(BuildContext context) {
    String res;
    Future.delayed(Duration(seconds: 3)).then((value){
      String x = otpCode;
      List resList=[];
      for(int i=0;i<=x.length-1;i++){
        resList.add(x[i]);
      }
      res= '${resList[3]}${resList[2]}${resList[1]}${resList[0]}';
      AuthCubit.get(context).putCode(res);
    });

    return BlocConsumer<AuthCubit,AuthState>(
        builder: (BuildContext context,Object? state){
      return   Scaffold(
        resizeToAvoidBottomInset: false,
          body: SafeArea(
            child:
                AuthCubit.get(context).isOtpCompleted==false?
                SingleChildScrollView(
                  reverse: true,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.h,),
                  SvgPicture.asset(ImagesManager.otp,
                    height: MediaQuery.of(context).size.height*0.40,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,right: 20.w),
                    child: Column(
                      children: <Widget>[
                        Text('رمز التحقق',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ) ,
                        Text('لقد أرسلنا كلمة مرور لمرة واحدة إلى بريدك الإلكتروني، يرجى كتابة الرمز هنا',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.20),
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 80.h,),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: PinCodeTextField(
                                autoDisposeControllers: false,
                                controller: AuthCubit.get(context).controllerOtpTest,
                                appContext: context,
                                length: 4,
                                onChanged: (val){

                                }),
                          ),
                        ),

                        SizedBox(height: 40.h,),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h, top: 64.h),
                          child:
                          AuthCubit.get(context).isLoading==true?Center(child: CircularProgressIndicator()):
                          CustomElevatedButton(
                              onTap: () {
                               if(type=='pass'){
                                 if(AuthCubit.get(context).controllerOtpTest.text.length ==4){
                                   AuthCubit.get(context).resetPassword(otpCode,context);
                                 }
                               }else{
                                 if(AuthCubit.get(context).controllerOtpTest.text.length ==4){
                                   AuthCubit.get(context).verifyAccount(otpCode,context);
                                 }
                               }
                              },
                              buttonText: '${getLang(context, 'count')}'),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                      ],
                    ),
                  ),
                ],
              ),
            ):
                Center(child: CircularProgressIndicator(),),
          )
      );
    }, listener:(BuildContext context,Object? state){});
  }
}
