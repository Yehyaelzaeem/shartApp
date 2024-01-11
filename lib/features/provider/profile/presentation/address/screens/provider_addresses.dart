import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/profile/presentation/address/widgets/custom_expansiontile_widget.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../auth/logic/auth_provider_cubit.dart';
import '../../../logic/provider_profile_cubit.dart';
import '../widgets/custom_add_address_button.dart';


class ProviderAddressesScreen extends StatelessWidget {
  const ProviderAddressesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
          child: CustomAppBar(title: 'عناويني', hasBackButton: true,
          onTap: (){
              ProviderProfileCubit.get(context).getProviderProfile('${AuthProviderCubit.get(context).token}', context);
              Navigator.pop(context);
          },
          ),
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
            child: BlocConsumer<ProviderProfileCubit,ProviderProfileState>(
              builder: (BuildContext context ,ProviderProfileState state){
                return
                  cubit.addressList !=null?
                  Column(
                  children: <Widget>[
                    CustomAddAddressButton(),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return
                          CustomExpansionTileWidget(index: index);
                      },
                      itemCount: cubit.addressList!.data!.length,
                      shrinkWrap: true,
                    ),
                  ],
                ) :Center(child: CircularProgressIndicator(),);
              },
              listener: (BuildContext context ,ProviderProfileState state){},
            )

          ),
        ),
      ),
    );
  }
}
