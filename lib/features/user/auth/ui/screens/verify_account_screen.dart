import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../widgets/custom_button.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        OtpTextField(
                          numberOfFields: 4,
                          borderColor: Color(0xFF512DA8),
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {
                          },
                          onSubmit: (String verificationCode){
                            if(verificationCode.length ==4){
                              AuthCubit.get(context).textFieldOtp=verificationCode;
                            }
                          }, // end onSubmit
                        ),
                        SizedBox(height: 40.h,),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h, top: 64.h),
                          child: CustomElevatedButton(
                              onTap: () {

                                if(AuthCubit.get(context).textFieldOtp.length ==4){
                                  String res='';
                                  for(int i=AuthCubit.get(context).textFieldOtp.length-1;i>=0;i--){
                                    res +=AuthCubit.get(context).textFieldOtp[i];
                                  }
                                  AuthCubit.get(context).verifyAccount(res,context);
                                }
                              },
                              buttonText: 'استمرار'),
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
