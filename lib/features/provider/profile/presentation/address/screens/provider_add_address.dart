import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/shared_screens/google_map/address_location_model.dart';
import 'package:shart/shared_screens/google_map/custom_google_map.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../widgets/show_toast_widget.dart';
import '../../../logic/provider_profile_cubit.dart';
import '../widgets/custom_radio_widget.dart';
class ProviderAddAddressScreen extends StatelessWidget{
   ProviderAddAddressScreen({super.key});
 final GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit.get(context).getLocation(context);
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
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
            BlocConsumer<ProviderProfileCubit ,ProviderProfileState>(
              builder: (BuildContext context ,ProviderProfileState state){
                AddressLocationModel? x =ProviderProfileCubit.get(context).addressLocationModel;
                return
                 Form(
                   key: formKeyAdd,
                     child:  Column(
                  children: <Widget>[
                    SizedBox(height: 10.h,),
                    // CustomRadioAddAddressWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: CustomTextField(
                          hintText: getLang(context, 'branch_name'),
                          validationFunc: (String? value){
                            if(value!.isEmpty){
                              return getLang(context, 'this_field_required');
                            }
                            return null;
                          },
                          hintColor: Colors.black,
                          controller: cubit.addressAddNameController),
                    ),
                    CustomTextField(
                        hintText: getLang(context, 'the_address'),
                        hintColor: Colors.black,
                        validationFunc: (String? value){
                          if(value!.isEmpty){
                            return getLang(context, 'this_field_required');
                          }
                          return null;
                        },
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
                        if(cubit.lat!=null&&cubit.long!=null){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>CustomGoogleMapScreen(
                            lat: cubit.lat!,
                            long: cubit.long!, type: 'provider',
                          )));
                        }else{
                          cubit.getLocation(context).then((LatLng value) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>CustomGoogleMapScreen(
                              lat: value.latitude,
                              long:value.longitude, type: 'provider',
                            )));
                          });
                        }

                      }, child: Row(
                      children: [
                        Icon(Icons.location_on_rounded,
                            color: Colors.grey.shade400),
                        SizedBox(width: 10,),
                        ProviderProfileCubit.get(context).addressLocationModel !=null?
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Text(
                            x!=null?'${x.country},${x.bigCity},${x.city},${x.locality},${x.street}':'',
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
                        validationFunc: (String? value){
                          if(value!.isEmpty){
                            return getLang(context, 'this_field_required');
                          }
                          return null;
                        },
                        textInputType: TextInputType.phone,
                        controller: cubit.addressAddPhoneController),
                    SizedBox(height: 10.h,),

                    cubit.isAddLoading?Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Center(child: CircularProgressIndicator(),),
                    ):Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child:
                      CustomElevatedButton(onTap: () {
                        if(formKeyAdd.currentState!.validate()){
                          if(x!=null){
                            cubit.addAddressProvider(AuthProviderCubit.get(context).token, context);
                          }else{
                            showToast(text: '${getLang(context, 'address_empty')}', state: ToastStates.error, context: context);

                          }
                        }
                      }, buttonText:  getLang(context, 'my_business_save'),),
                    ),
                  ],
                ));
              },
              listener: (BuildContext context ,ProviderProfileState state){},
            )

        ),
      ),
    );
  }
}
