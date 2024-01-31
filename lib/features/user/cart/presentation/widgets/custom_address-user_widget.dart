import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../shared_screens/google_map/custom_google_map.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../logic/cart_cubit.dart';

class CustomAddressUserWidget extends StatelessWidget {
  const CustomAddressUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // print('buillllld adderss');
    CartCubit cubit =CartCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, 'delivery_address'),
          style:
          TextStyle(
              fontFamily: FontConstants.Tajawal,
              fontSize: 24,
              color: blackTextColor,
              fontWeight: FontWeight.w500
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 10.h,),
        Text(
          getLang(context, 'the_address'),
          style:
          TextStyle(
              fontFamily: FontConstants.lateefFont,
              fontSize: 14,
              color: blackTextColor,
              fontWeight: FontWeight.w500
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 5.h,),
        CustomTextField(
            hintText: '',
            hintColor: Colors.black,
            controller:cubit.addressController),
        SizedBox(height: 10.h,),
        Text(
          getLang(context, 'the_location'),
          style:
          TextStyle(
              fontFamily: FontConstants.lateefFont,
              fontSize: 14,
              color: blackTextColor,
              fontWeight: FontWeight.w500
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 5.h,),
        InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
                CustomGoogleMapScreen(
              lat: cubit.lat!,
              long: cubit.long!, type: 'user',
            )));
          },
          child: CustomTextField(
            enabled: false,
              maxLines: 2,
              prefixIcon: Icon(Icons.location_on_outlined),
              hintText: cubit.addressLocationModel!=null?'${cubit.addressLocationModel!.country}/${cubit.addressLocationModel!.bigCity}/${cubit.addressLocationModel!.locality}\n/${cubit.addressLocationModel!.city}/${cubit.addressLocationModel!.street}':'',
              hintColor: Colors.black,
              controller: TextEditingController()),
        ),
        SizedBox(height: 15.h,),
        Text(
          getLang(context, 'street_name'),
          style:
          TextStyle(
              fontFamily: FontConstants.lateefFont,
              fontSize: 14,
              color: blackTextColor,
              fontWeight: FontWeight.w500
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 5.h,),
        CustomTextField(
            hintText: '',
            hintColor: Colors.black,
            controller: cubit.addressStreetController),
        SizedBox(height: 15.h,),
        Text(
          getLang(context, 'building_number'),
          style:
          TextStyle(

              fontFamily: FontConstants.lateefFont,
              fontSize: 14,
              color: blackTextColor,
              fontWeight: FontWeight.w500
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 5.h,),
        CustomTextField(
          textInputType: TextInputType.number,
            hintText: '',
            hintColor: Colors.black,
            controller:cubit.addressNuHouseController),
        SizedBox(height: 15.h,),
        Text(
          getLang(context, 'special_marque'),
          style:
          TextStyle(
              fontFamily: FontConstants.lateefFont,
              fontSize: 14,
              color: blackTextColor,
              fontWeight: FontWeight.w500
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 5.h,),
        CustomTextField(
            hintText: '',
            hintColor: Colors.black,
            controller: cubit.addressMarkController),
        SizedBox(height: 40.h,),
      ],
    );
  }
}
