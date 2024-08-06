import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/shared_screens/google_map/address_location_model.dart';
import 'package:shart/shared_screens/google_map/custom_google_map.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../auth/logic/auth_cubit.dart';
import '../../../logic/user_profile_cubit.dart';
import '../widgets/custom_radio_widget.dart';
class UserAddAddressScreen extends StatelessWidget{
  const UserAddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProfileCubit.get(context).getLocation(context);
    UserProfileCubit cubit =UserProfileCubit.get(context);
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
                return     Column(
                  children: <Widget>[
                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: CustomTextField(
                          hintText: getLang(context, 'street_name'),
                          hintColor: Colors.black,
                          controller: cubit.addressAddNameController),
                    ),
                    CustomTextField(
                        hintText: getLang(context, 'the_address'),
                        hintColor: Colors.black,
                        controller: cubit.addressAddController),
                    SizedBox(height: 24.h,),
                    MaterialButton(
                      minWidth: 150.w,
                      height: 50.h,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade400.withOpacity(0.80)),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      onPressed: ()async{
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>CustomGoogleMapScreen(
                         lat: cubit.lat!,
                         long: cubit.long!, type: 'userAddress',
                       )));
                      }, child: Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              color: Colors.grey.shade400),
                          SizedBox(width: 10,),
                          UserProfileCubit.get(context).addressLocationModel !=null?
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
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
                            width: MediaQuery.of(context).size.width*0.7,
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
                        hintText:  getLang(context, 'phone_nu'),
                        hintColor: Colors.black,
                        textInputType: TextInputType.phone,
                        controller: cubit.addressAddPhoneController),
                    SizedBox(height: 24.h,),
                    CustomTextField(
                        hintText:  getLang(context, 'special_marque'),
                        hintColor: Colors.black,
                        textInputType: TextInputType.phone,
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
                        cubit.addAddressUser(AuthCubit.get(context).token, context);
                      }, buttonText:  getLang(context, 'my_business_save'),),
                    ),
                  ],
                );
              },
              listener: (BuildContext context ,UserProfileState state){},
            )

        ),
      ),
    );
  }
}
