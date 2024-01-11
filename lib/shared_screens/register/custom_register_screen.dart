import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/shared_screens/register/widgets/custom_body_register.dart';
import '../../core/resources/assets_menager.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/routing/routes.dart';
import '../../features/provider/auth/logic/auth_provider_cubit.dart';
import '../../features/user/auth/logic/auth_cubit.dart';
import '../../widgets/image/custom_image_top.dart';
import '../../widgets/title/cutom_tilte.dart';
import '../login/widgets/custom_container.dart';

class CustomRegisterScreen extends StatelessWidget {
  const CustomRegisterScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    AuthProviderCubit providerCubit =AuthProviderCubit.get(context);
    AuthCubit userCubit =AuthCubit.get(context);
    return   PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        type=='user'?
        NavigationManager.pushReplacement(Routes.login):
        NavigationManager.pushReplacement(Routes.providerLogin);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body:
        SingleChildScrollView(
          child: Form(
            key:type=='user'? userCubit.registerFormKey:providerCubit.registerFormKeyProvider,
            child: Column(
              children: <Widget>[
                CustomImageTop(image:  ImagesManager.introduction3,),
                CustomTitle(title: 'إنشاء حساب',),
                type=='user'?
                CustomContainer(widget:  BlocConsumer<AuthCubit,AuthState>(
                  builder: (BuildContext context,AuthState state){
                    return CustomBodyRegister(type: type, providerCubit: providerCubit, userCubit: userCubit,);
                  },
                  listener: (BuildContext context,AuthState state){},
                ),):
                CustomContainer(widget:  BlocConsumer<AuthProviderCubit,AuthProviderState>(
                  builder: (BuildContext context,AuthProviderState state){
                    return CustomBodyRegister(type: type, providerCubit: providerCubit, userCubit: userCubit,);
                  },
                  listener: (BuildContext context,AuthProviderState state){},
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
