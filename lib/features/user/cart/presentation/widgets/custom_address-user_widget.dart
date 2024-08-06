import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/provider/profile/data/model/address_list_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../shared_screens/google_map/custom_google_map.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../profile/logic/user_profile_cubit.dart';
import '../../../profile/presentation/address/screens/user_add_address.dart';
import '../../logic/cart_cubit.dart';

class CustomAddressUserWidget extends StatelessWidget {
   CustomAddressUserWidget({super.key});
  int currentMethod=0;
  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit =CartCubit.get(context);

    UserProfileCubit cubit =UserProfileCubit.get(context);
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
        BlocConsumer<UserProfileCubit,UserProfileState>(
          builder: (BuildContext context ,UserProfileState state){
            if( cubit.addressList !=null){
              if(cubit.addressList!.data!=null&&cubit.addressList!.data!.isNotEmpty){
                return StatefulBuilder(builder: (BuildContext context,setState){
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400)
                    ),
                    height: MediaQuery.of(context).size.height*0.4,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...cubit.addressList!.data!.map((AddressModelData e) =>  Padding(
                              padding:  EdgeInsets.symmetric(vertical: 2.h),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    borderRadius: BorderRadius.circular(8.sp)
                                ),
                                child:
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor:primaryColor,
                                      value: e.id!,
                                      groupValue: currentMethod,
                                      onChanged: (int? value) {
                                        setState(() {
                                          cartCubit.orderAddressModelData=e;
                                          currentMethod = value!;
                                        });
                                      },
                                    ),
                                    Expanded(child: InkWell(
                                        onTap: (){
                                          showToast(text: e.address!, state: ToastStates.success, context: context);
                                        },
                                        child: Text(e.name!))),
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  );


                });
              }
              else{
                return Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                  child: Column(
                    children: [
                      Center(child: Text(getLang(context, 'there_no_addresses')),),
                      SizedBox(height: 50.h,),
                      CustomElevatedButton(
                          backgroundColor: Colors.white,
                          borderColor:Colors.grey,
                          fontColor: Colors.black,
                          borderRadius: 8,
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                UserAddAddressScreen()
                            ));
                          },
                          buttonText:getLang(context, 'adding_address'))
                    ],
                  ),
                );
              }
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
          listener: (BuildContext context ,UserProfileState state){},
        )

      // Column(
      //   children: [
      //     Text(
      //       getLang(context, 'the_address'),
      //       style:
      //       TextStyle(
      //           fontFamily: FontConstants.lateefFont,
      //           fontSize: 14,
      //           color: blackTextColor,
      //           fontWeight: FontWeight.w500
      //       ),
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis,
      //       textAlign: TextAlign.start,
      //     ),
      //     SizedBox(height: 5.h,),
      //     CustomTextField(
      //         hintText: '',
      //         hintColor: Colors.black,
      //         controller:cubit.addressController),
      //     SizedBox(height: 10.h,),
      //     Text(
      //       getLang(context, 'the_location'),
      //       style:
      //       TextStyle(
      //           fontFamily: FontConstants.lateefFont,
      //           fontSize: 14,
      //           color: blackTextColor,
      //           fontWeight: FontWeight.w500
      //       ),
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis,
      //       textAlign: TextAlign.start,
      //     ),
      //     SizedBox(height: 5.h,),
      //     InkWell(
      //       onTap: (){
      //         if(cubit.lat!=null&&cubit.long!=null){
      //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
      //               CustomGoogleMapScreen(
      //                 lat: cubit.lat!,
      //                 long: cubit.long!, type: 'user',
      //               )));
      //         }
      //       },
      //       child: CustomTextField(
      //           enabled: false,
      //           maxLines: 2,
      //           prefixIcon: Icon(Icons.location_on_outlined),
      //           hintText: cubit.addressLocationModel!=null?'${cubit.addressLocationModel!.country}/${cubit.addressLocationModel!.bigCity}/${cubit.addressLocationModel!.locality}\n/${cubit.addressLocationModel!.city}/${cubit.addressLocationModel!.street}':'',
      //           hintColor: Colors.black,
      //           controller: TextEditingController()),
      //     ),
      //     SizedBox(height: 15.h,),
      //     Text(
      //       getLang(context, 'street_name'),
      //       style:
      //       TextStyle(
      //           fontFamily: FontConstants.lateefFont,
      //           fontSize: 14,
      //           color: blackTextColor,
      //           fontWeight: FontWeight.w500
      //       ),
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis,
      //       textAlign: TextAlign.start,
      //     ),
      //     SizedBox(height: 5.h,),
      //     CustomTextField(
      //         hintText: '',
      //         hintColor: Colors.black,
      //         controller: cubit.addressStreetController),
      //     SizedBox(height: 15.h,),
      //     Text(
      //       getLang(context, 'building_number'),
      //       style:
      //       TextStyle(
      //
      //           fontFamily: FontConstants.lateefFont,
      //           fontSize: 14,
      //           color: blackTextColor,
      //           fontWeight: FontWeight.w500
      //       ),
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis,
      //       textAlign: TextAlign.start,
      //     ),
      //     SizedBox(height: 5.h,),
      //     CustomTextField(
      //         textInputType: TextInputType.number,
      //         hintText: '',
      //         hintColor: Colors.black,
      //         controller:cubit.addressNuHouseController),
      //     SizedBox(height: 15.h,),
      //     Text(
      //       getLang(context, 'special_marque'),
      //       style:
      //       TextStyle(
      //           fontFamily: FontConstants.lateefFont,
      //           fontSize: 14,
      //           color: blackTextColor,
      //           fontWeight: FontWeight.w500
      //       ),
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis,
      //       textAlign: TextAlign.start,
      //     ),
      //     SizedBox(height: 5.h,),
      //     CustomTextField(
      //         hintText: '',
      //         hintColor: Colors.black,
      //         controller: cubit.addressMarkController),
      //     SizedBox(height: 40.h,),
      //   ],
      // )
      ],
    );
  }
}
