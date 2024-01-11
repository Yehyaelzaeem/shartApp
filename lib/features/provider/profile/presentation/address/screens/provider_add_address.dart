import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/shared_screens/google_map/custom_google_map.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../logic/provider_profile_cubit.dart';
import '../widgets/custom_radio_widget.dart';
class ProviderAddAddressScreen extends StatefulWidget{
  const ProviderAddAddressScreen({super.key});

  @override
  State<ProviderAddAddressScreen> createState() => _ProviderAddAddressScreenState();
}

class _ProviderAddAddressScreenState extends State<ProviderAddAddressScreen> {
  var selectValue='العنوان الرئيسي';
  // static final CameraPosition kGoogle= CameraPosition(
  //     target: LatLng(21.422390,39.7822));
  late GoogleMapController mapController;
  double? lat;
  double? long;
 @override
  void initState() {

   getloc();
    // TODO: implement initState
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position? p ;
  Future<void> getloc()async{
    p =await Geolocator.getCurrentPosition().then((value) {
      lat=value.latitude;
      long=value.longitude;
      print('lat : => $lat');
      print('long : => $long');
    });
  }
  final LatLng _center =  LatLng(251354,15);

  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit =ProviderProfileCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: 'أضف عنوان',
          hasBackButton: true,
        ),
        preferredSize: Size(double.infinity, 80.h),
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
                var x =ProviderProfileCubit.get(context).addressLocationModel;
                return     Column(
                  children: <Widget>[
                    CustomRadioAddAddressWidget(),
                    if (cubit.addressType == 1)
                      Padding(
                        padding: EdgeInsets.only(top: 25.h),
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          hint: Text(
                           '${selectValue}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          items: <String>['عنوان1', 'عنوان2', 'عنوان3']
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectValue = value!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.grey.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8.r))),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: CustomTextField(
                          hintText: 'اسم الفرع',
                          hintColor: Colors.black,
                          controller: cubit.addressAddNameController),
                    ),
                    CustomTextField(
                        hintText: 'العنوان',
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
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CustomGoogleMapScreen(
                         lat: lat!,
                         long: long!,
                       )));
                      }, child: Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              color: Colors.grey.shade400),
                          SizedBox(width: 10,),
                          ProviderProfileCubit.get(context).addressLocationModel !=null?
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
                            child: Text('الموقع',
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 24.h),
                    //   child: CustomTextField(
                    //     hintText: 'الموقع',
                    //     controller: TextEditingController(),
                    //     prefixIcon: Icon(Icons.location_on_rounded,
                    //         color: Colors.grey.shade400),
                    //     hintColor: Colors.black,
                    //   ),
                    // ),
                    SizedBox(height: 24.h,),
                    CustomTextField(
                        hintText: 'رقم التليفون',
                        hintColor: Colors.black,
                        textInputType: TextInputType.phone,
                        controller: cubit.addressAddPhoneController),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child:
                      CustomElevatedButton(onTap: () {
                        cubit.addAddressProvider(AuthProviderCubit.get(context).token, context);
                      }, buttonText: 'حفظ'),
                    ),
                  ],
                );
              },
              listener: (BuildContext context ,ProviderProfileState state){},
            )

        ),
      ),
    );
  }
}
