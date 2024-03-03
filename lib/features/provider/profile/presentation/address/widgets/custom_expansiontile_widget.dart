import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../../shared_screens/google_map/custom_google_map.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../auth/logic/auth_provider_cubit.dart';
import '../../../logic/provider_profile_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTileWidget extends StatelessWidget {
  const CustomExpansionTileWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    return    BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
  listener: (BuildContext context,ProviderProfileState state) {},
  builder: (BuildContext context,ProviderProfileState state) {
    return ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(vertical: 10),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        textColor: Colors.black,
        collapsedTextColor: Colors.black,
        title: Text('${cubit.addressList!.data![index].name}',
            style: TextStyle(
                fontFamily: 'Lateef',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold)),
        children: <Widget>[
          Text(
            getLang(context, 'branch_name'),
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500),
          ),
          TextField(
              controller:cubit.addressNameController ,
              decoration: InputDecoration(
                  hintText: '${cubit.addressList!.data![index].name}',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: 'Lateef',
                      color: Color(0xff4B4B4B)))),
          SizedBox(height: 25.h),
          Text(
            getLang(context, 'the_address'),
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500),
          ),
          TextField(
              controller:cubit.addressController ,
              decoration: InputDecoration(
                  hintText:
                  '${cubit.addressList!.data![index].address}',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: 'Lateef',
                      color: Color(0xff4B4B4B)))),
          SizedBox(height: 25.h),
          Text(
            getLang(context, 'the_location'),
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: (){
              // ProviderProfileCubit.get(context).getLocation(context);
              Navigator.push(context, MaterialPageRoute(builder:
                  (BuildContext context)=>CustomGoogleMapScreen(
                    id: cubit.addressList!.data![index].id,
                lat: double.parse(cubit.addressList!.data![index].lat.toString()),
                long:double.parse(cubit.addressList!.data![index].lng.toString()),
                type: 'providerAddress',
              )));
            },
            child:
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText:

                cubit.addressLocationModelEditor!=null?
                cubit.addressList!.data![index].id==cubit.addressLocationModelEditor!.id?
                '${cubit.addressLocationModelEditor!.country}/${cubit.addressLocationModelEditor!.bigCity}'
                    '/${cubit.addressLocationModelEditor!.city}/${cubit.addressLocationModelEditor!.locality}/${cubit.addressLocationModelEditor!.street}':
                '${cubit.addressList!.data![index].note!=null&&cubit.addressList!.data![index].note!.isNotEmpty?cubit.addressList!.data![index].note:'lat : ${cubit.addressList!.data![index].lat} / long : ${cubit.addressList!.data![index].lng}'}':
                '${cubit.addressList!.data![index].note!=null&&cubit.addressList!.data![index].note!.isNotEmpty?cubit.addressList!.data![index].note:'lat : ${cubit.addressList!.data![index].lat} / long : ${cubit.addressList!.data![index].lng}'}',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  color: Color(0xff4B4B4B),
                ),
                disabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // Change this color to your desired color
                    width: 1.0, // You can also adjust the width if needed
                  ),
                ),
              ),
            ),

          ),
          SizedBox(height: 25.h),
          Text(
            getLang(context, 'phone_nu'),
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500),
          ),

          TextField(
              controller:cubit.addressPhoneController,
              decoration: InputDecoration(
                  hintText: '${cubit.addressList!.data![index].phone}',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: 'Lateef',
                      color: Color(0xff4B4B4B)),
              )),

          SizedBox(height: 25.h),
          cubit.isUpdateLoading?Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(child: CircularProgressIndicator(),),
          ):Padding(
            padding: EdgeInsets.only(bottom: 15.h, top: 15.h),
            child: CustomElevatedButton(
                onTap: () {
                  cubit.editAddressProvider(cubit.addressList!.data![index],int.parse('${cubit.addressList!.data![index].id}'), AuthProviderCubit.get(context).token, context).then((value) {
                  });
                }, buttonText: getLang(context, 'update_data')),
          ),
          cubit.isAddLoading?Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(child: CircularProgressIndicator(),),
          ):CustomElevatedButton(
              onTap: () {
                cubit.deleteAddressProvider(int.parse('${cubit.addressList!.data![index].id}'), AuthProviderCubit.get(context).token, context);
              },
              buttonText: getLang(context, 'delete_address'),
              backgroundColor: Colors.white,
              borderColor: Colors.black),
        ]);
  },
);
  }
}
