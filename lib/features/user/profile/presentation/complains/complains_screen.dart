import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/functions/general_functions.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../logic/user_profile_cubit.dart';

class ComplainsScreen extends StatelessWidget {
  const ComplainsScreen({Key? key,  required this.type}) : super(key: key);
  final String type;
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: getLang(context,'complaints_suggestions'),hasBackButton: true,
        onTap: (){
          Navigator.pop(context);
        },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Image.asset(ImagesManager.complain),
            Padding(
              padding: EdgeInsets.only(bottom: 70.h, top: 30.h),
              child: TextFormField(
                onTapOutside: (PointerDownEvent v) {
                  GeneralFunctions.hideKeyboard();
                },
                onChanged: (String v) =>
                    GeneralFunctions.unFocusCursorRTL(cubit.complainController),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: getLang(context,'please_write'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                controller: cubit.complainController,
                textInputAction: TextInputAction.done,
              ),
            ),
            BlocConsumer<UserProfileCubit,UserProfileState>(builder:
            (BuildContext context,UserProfileState state){
              return
                UserProfileCubit.get(context).isUpdateLoading==false?
                CustomElevatedButton(onTap: () {
                cubit.sendComplaintMessage(type!, context);
              }, buttonText: getLang(context,'send')):
                    Center(child: CircularProgressIndicator(),);
            },
                listener: (BuildContext context,UserProfileState state){})
          ],
        ),
      ),
    );
  }
}
