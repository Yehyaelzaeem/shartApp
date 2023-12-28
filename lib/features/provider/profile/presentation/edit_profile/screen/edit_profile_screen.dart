import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';

import '../../../../../../core/resources/assets_menager.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../logic/provider_profile_cubit.dart';


class ProviderEditProfileScreen extends StatelessWidget {
  const ProviderEditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ProviderEditProfileScreen building ===================');
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    return WillPopScope(
      onWillPop: (){
        ProviderProfileCubit.get(context).getProviderProfile('${AuthProviderCubit.get(context).token}', context);
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80.h),
            child:
                CustomAppBar(title: 'تعديل بيانات الحساب', hasBackButton: true,
                  onTap: (){
                    ProviderProfileCubit.get(context).getProviderProfile('${AuthProviderCubit.get(context).token}', context);
                    Navigator.pop(context);
                  },
                )),
        body:
        BlocConsumer<ProviderProfileCubit,ProviderProfileState>(
          builder:(BuildContext context ,ProviderProfileState state){
            return
              ProviderProfileCubit.get(context).isUpdateLoading==false?
              SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        cubit.providerProfileModel !=null?
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child:
                          cubit.profileImageProviderFile !=null?
                          CircleAvatar(
                              radius:60,
                              backgroundImage:
                              FileImage(cubit.profileImageProviderFile!)
                          ):
                        CircleAvatar(
                              radius:60,
                              backgroundImage:
                              NetworkImage('${cubit.providerProfileModel!.data!.image}')
                          ),):
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                              radius:60,
                              backgroundImage:
                              NetworkImage(ImagesManager.testLogo)
                          ),),
                        CircleAvatar(
                          backgroundColor: greyColor,
                          child: IconButton(
                            onPressed: () {
                              cubit.uploadImage();
                            },
                            icon: Icon(Icons.camera_alt_outlined,color:Colors.white,size: 23,),
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomTextField(
                    prefixIcon: Icon(Icons.person),
                    hintText: '${cubit.providerProfileModel!.data!.name}',
                    controller: cubit.nameController,
                    textInputType: TextInputType.name,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: CustomTextField(
                      hintText: '${cubit.providerProfileModel!.data!.email}',
                      prefixIcon: Icon(Icons.email),
                      controller: cubit.emailController,
                    ),
                  ),
                  CustomTextField(
                    hintText: '${cubit.providerProfileModel!.data!.phone}',
                    controller: cubit.phoneController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.phone,
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 110.h, bottom: 15.h),
                    child: CustomElevatedButton(
                        onTap: () {
                          cubit.updateProviderProfile(
                              ProviderProfileCubit.get(context).providerProfileModel!, AuthProviderCubit.get(context).token, context);

                        }, buttonText: 'تحديث البيانات'),
                  ),
                  CustomElevatedButton(
                    onTap: () {
                      NavigationManager.push(Routes.providerForgetPassword);
                    },
                    buttonText: 'تحديث كلمة المرور',
                    backgroundColor: whiteColor,
                    borderColor: blackColor,
                  ),
                ],
              ),
            ):
              Center(child: CircularProgressIndicator(),);
          },
          listener: (BuildContext context, ProviderProfileState state) {  },

        )
      ),
    );
  }
}
