import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/provider/profile/presentation/address/widgets/custom_expansiontile_widget.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../logic/provider_profile_cubit.dart';
import '../widgets/custom_add_address_button.dart';


class ProviderAddressesScreen extends StatelessWidget {
  const ProviderAddressesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
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
          child: BlocConsumer<ProviderProfileCubit,ProviderProfileState>(
            builder: (BuildContext context ,ProviderProfileState state){
              return
                cubit.addressList !=null?
                Column(
                children: <Widget>[
                  CustomAddAddressButton(),
                  cubit.addressList!.data!.length==0?
                      Padding(
                        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),
                        child: Center(child: Text(getLang(context, 'There_addresses_currently')),),
                      ):
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
              ) :
                Center(child: CircularProgressIndicator(),);
            },
            listener: (BuildContext context ,ProviderProfileState state){},
          )
        ),
      ),
    );
  }
}
