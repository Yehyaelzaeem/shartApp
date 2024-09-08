import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../logic/user_profile_cubit.dart';
import '../widgets/custom_add_address_button.dart';
import '../widgets/custom_expansiontile_widget.dart';


class UserAddressesScreen extends StatelessWidget {
  const UserAddressesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserProfileCubit.get(context).getLocation(context);

    UserProfileCubit cubit =UserProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(title: getLang(context, 'my_addresses'), hasBackButton: true,),
      ),
      body: Container(
        height: ScreenUtil().screenHeight * 0.85,
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            border: Border.all(color: Colors.grey)),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
          BlocConsumer<UserProfileCubit,UserProfileState>(
            builder: (BuildContext context ,UserProfileState state){
              if( cubit.addressList !=null){
                return  Column(
                  children: <Widget>[
                    CustomAddAddressButton(),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return
                          // Center(child: Text('${cubit.addressList!.data![index].name}'),);
                          CustomExpansionTileUserWidget(addressModelData: cubit.addressList!.data![index],);
                      },
                      itemCount: cubit.addressList!.data!.length,
                      shrinkWrap: true,
                    ),
                  ],
                );
              }
              return Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5),
                child: Center(child: CircularProgressIndicator(),),
              );
            },
            listener: (BuildContext context ,UserProfileState state){},
          )
        ),
      ),
    );
  }
}
