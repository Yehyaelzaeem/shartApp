import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/profile/logic/provider_profile_cubit.dart';
import 'package:shart/shared_screens/more_screen/widgets/custom_body_more.dart';
import '../../core/localization/appLocale.dart';
import '../../features/provider/profile/data/model/user_profile_model.dart';
import '../../features/user/profile/data/model/user_profile_model.dart';
import '../../features/user/profile/logic/user_profile_cubit.dart';
import '../../widgets/custom_app_bar.dart';

class CustomMoreScreen extends StatelessWidget {
  const CustomMoreScreen({super.key, required this.type});
 final String type;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(title: getLang(context,'the_more'),),
          preferredSize: Size(double.infinity, 80.h),
        ),
        body:
        type=='user'?
        BlocBuilder<UserProfileCubit,UserProfileState>(
          builder: (BuildContext context, UserProfileState state) {
             if(UserProfileCubit.get(context).userProfileModel!=null)
            {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: CustomBodyMore(userProfileModel: UserProfileCubit.get(context).userProfileModel, type: 'user',),
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ):
        BlocBuilder<ProviderProfileCubit,ProviderProfileState>(
          builder: (BuildContext context, ProviderProfileState state1) {
            if(ProviderProfileCubit.get(context).providerProfileModel !=null)
      {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: CustomBodyMore( providerGetProfileModel: ProviderProfileCubit.get(context).providerProfileModel, type: 'provider',),
          ),
        );
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    },)
    );
  }
}
