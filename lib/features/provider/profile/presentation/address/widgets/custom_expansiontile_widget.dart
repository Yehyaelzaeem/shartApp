import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return    ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(vertical: 10),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        textColor: Colors.black,
        collapsedTextColor: Colors.black,
        title: Text('${cubit.addressList!.data![index].name}',
            style: TextStyle(
                fontFamily: 'Lateef',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold)),
        children: [
          Text(
            'أسم الفرع',
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
            'العنوان',
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
            'الموقع',
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500),
          ),
          TextField(

            decoration: InputDecoration(
                hintText:
                'Talha ST, 8498، 4965 8498  حي النسيم الشرقى 23338 8498, Saudi Arabia',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    color: Color(0xff4B4B4B))),
          ),
          SizedBox(height: 25.h),
          Text(
            'رقم التليفون',
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
          Padding(
            padding: EdgeInsets.only(bottom: 15.h, top: 15.h),
            child: CustomElevatedButton(
                onTap: () {
                  cubit.editAddressProvider(cubit.addressList!.data![index],int.parse('${cubit.addressList!.data![index].id}'), AuthProviderCubit.get(context).token, context).then((value) {
                  });
                }, buttonText: 'حفظ التعديل'),
          ),
          CustomElevatedButton(
              onTap: () {
                cubit.deleteAddressProvider(int.parse('${cubit.addressList!.data![index].id}'), AuthProviderCubit.get(context).token, context);
              },
              buttonText: 'مسح العنوان',
              backgroundColor: Colors.white,
              borderColor: Colors.black),
        ]);
  }
}
