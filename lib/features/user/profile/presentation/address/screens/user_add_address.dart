
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/localization/appLocale.dart';
import '../../../../../../shared_screens/google_map/address_location_model.dart';
import '../../../../../../shared_screens/google_map/custom_google_map.dart';
import '../../../../../../widgets/custom_app_bar.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text_field.dart';
import '../../../../../../widgets/show_toast_widget.dart';
import '../../../../auth/logic/auth_cubit.dart';
import '../../../logic/user_profile_cubit.dart';

class UserAddAddressScreen extends StatelessWidget{
   UserAddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {

    UserProfileCubit.get(context).getLocation(context);
    UserProfileCubit cubit =UserProfileCubit.get(context);
    print('buildssssssssssssssssssssssssssssssssssssssssssssss');
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: getLang(context,'adding_address'),
          hasBackButton: true,
        ),
        preferredSize: Size(double.infinity, 70.h),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: ScreenUtil().screenHeight * 0.85,
            margin: EdgeInsets.only(top: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border.all(color: Colors.grey)),
            child:
            BlocConsumer<UserProfileCubit ,UserProfileState>(
              builder: (BuildContext context ,UserProfileState state){
                AddressLocationModel? x =UserProfileCubit.get(context).addressLocationModel;
                return
                  Form(
                    key: cubit.formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: CustomTextField(
                            validationFunc: (String? value){
                              if(value!.isEmpty){
                                return getLang(context, 'this_field_required');
                              }
                              return null;
                            },
                            hintText: getLang(context, 'street_name'),
                            hintColor: Colors.black,
                            controller: cubit.addressAddNameController),
                      ),
                      CustomTextField(
                          validationFunc: (String? value){
                            if(value!.isEmpty){
                              return getLang(context, 'this_field_required');
                            }
                            return null;
                          },
                          hintText: getLang(context, 'the_address'),
                          hintColor: Colors.black,
                          controller: cubit.addressAddController),
                      SizedBox(height: 24.h,),
                      MaterialButton(
                        minWidth: 150.w,
                        height:50.h,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade400.withOpacity(0.80)),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        onPressed: ()async{
                          if(cubit.lat!=null){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>CustomGoogleMapScreen(
                              lat: cubit.lat!,
                              long: cubit.long!, type: 'userAddress',
                            )));
                          }else{
                            cubit.getLocation(context).then((LatLng value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>CustomGoogleMapScreen(
                                lat: value.latitude,
                                long:value.longitude, type: 'userAddress',
                              )));
                            });
                          }

                        }, child: Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              color: Colors.grey.shade400),
                          SizedBox(width: 10,),
                          UserProfileCubit.get(context).addressLocationModel !=null?
                          Container(
                            width: 265.w,
                            child: Text(
                              '${x!.country},${x.bigCity},${x.city},${x.locality},${x.street}',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.60)
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ):
                          Container(
                            width: 265.w,

                            child: Text( getLang(context, 'the_location'),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.60)
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      ),
                      SizedBox(height: 24.h,),
                      CustomTextField(
                          validationFunc: (String? value){
                            if(value!.isEmpty){
                              return getLang(context, 'this_field_required');
                            }
                            return null;
                          },
                          hintText:  getLang(context, 'phone_nu'),
                          hintColor: Colors.black,
                          textInputType: TextInputType.phone,
                          controller: cubit.addressAddPhoneController),
                      SizedBox(height: 24.h,),
                      CustomTextField(
                          hintText:  getLang(context, 'special_marque'),
                          hintColor: Colors.black,
                          controller: cubit.addressNoteController),
                      cubit.isAddLoading?
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(child: CircularProgressIndicator(),),
                      ):
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child:
                        CustomElevatedButton(onTap: () {
                          if(cubit.formKey.currentState!.validate()){
                            if(x!=null){
                              cubit.addAddressUser(AuthCubit.get(context).token, context);
                            }else{
                              showToast(text: '${getLang(context, 'address_empty')}', state: ToastStates.error, context: context);
                            }
                          }
                        }, buttonText:  getLang(context, 'my_business_save'),),
                      ),
                    ],
                  ),
                  );
              },
              listener: (BuildContext context ,UserProfileState state){},
            )

        ),
      ),
    );
  }
}
