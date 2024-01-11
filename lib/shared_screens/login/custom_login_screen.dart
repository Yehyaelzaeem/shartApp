import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/shared_screens/login/widgets/custom_body_login.dart';
import 'package:shart/shared_screens/login/widgets/custom_container.dart';
import '../../core/resources/assets_menager.dart';
import '../../features/provider/auth/logic/auth_provider_cubit.dart';
import '../../features/user/auth/logic/auth_cubit.dart';
import '../../widgets/image/custom_image_top.dart';
import '../../widgets/title/cutom_tilte.dart';

class CustomLoginScreen extends StatelessWidget {
  const CustomLoginScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    AuthProviderCubit providerCubit =AuthProviderCubit.get(context);
    AuthCubit userCubit =AuthCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: type=='user'? userCubit.formKey:providerCubit.formKeyProvider,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomImageTop(image:  ImagesManager.introduction1,),
              CustomTitle(title: 'تسجيل الدخول',),
              type=='user'?
              CustomContainer(widget:
              BlocConsumer<AuthCubit,AuthState>(
                  builder: (BuildContext context,AuthState state){
                    return CustomBodyLogin(type:type , providerCubit: providerCubit, userCubit: userCubit,);
                  },
                  listener: (BuildContext context,AuthState state){},
                ),):
              CustomContainer(widget:
              BlocConsumer<AuthProviderCubit,AuthProviderState>(
                builder: (BuildContext context,AuthProviderState state){
                  return CustomBodyLogin(type: type, providerCubit: providerCubit, userCubit: userCubit,);
                },
                listener: (BuildContext context,AuthProviderState state){},
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
