import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../../widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../auth/logic/auth_cubit.dart';
import '../../../logic/user_profile_cubit.dart';

class CustomExpansionTileUserWidget extends StatelessWidget {
  const CustomExpansionTileUserWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    UserProfileCubit cubit =UserProfileCubit.get(context);
    return    BlocConsumer<UserProfileCubit, UserProfileState>(
  listener: (BuildContext context,UserProfileState state) {},
  builder: (BuildContext context,UserProfileState state) {
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
          TextField(
            decoration: InputDecoration(
                hintText:
                'lat : ${cubit.addressList!.data![index].lat} / long : ${cubit.addressList!.data![index].lng}',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    color: Color(0xff4B4B4B))),
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
                      color: Color(0xff4B4B4B)))),
          SizedBox(height: 25.h),
          cubit.isUpdateLoading?Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(child: CircularProgressIndicator(),),
          ):Padding(
            padding: EdgeInsets.only(bottom: 15.h, top: 15.h),
            child: CustomElevatedButton(
                onTap: () {
                  cubit.editAddressUser(cubit.addressList!.data![index],int.parse('${cubit.addressList!.data![index].id}'), AuthCubit.get(context).token, context).then((value) {
                  });
                }, buttonText: getLang(context, 'update_data')),
          ),
          cubit.isAddLoading?Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(child: CircularProgressIndicator(),),
          ):CustomElevatedButton(
              onTap: () {
                cubit.deleteAddressUser(int.parse('${cubit.addressList!.data![index].id}'), AuthCubit.get(context).token, context);
              },
              buttonText: getLang(context, 'delete_address'),
              backgroundColor: Colors.white,
              borderColor: Colors.black),
        ]);
  },
);
  }
}
