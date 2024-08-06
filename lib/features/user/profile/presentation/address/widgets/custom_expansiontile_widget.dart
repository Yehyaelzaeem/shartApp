import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../../shared_screens/google_map/address_location_model.dart';
import '../../../../../../shared_screens/google_map/custom_google_map.dart';
import '../../../../../../widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../provider/profile/data/model/address_list_model.dart';
import '../../../../auth/logic/auth_cubit.dart';
import '../../../logic/user_profile_cubit.dart';

class CustomExpansionTileUserWidget extends StatefulWidget {
  const CustomExpansionTileUserWidget({super.key, required this.addressModelData});
  final AddressModelData addressModelData;

  @override
  State<CustomExpansionTileUserWidget> createState() => _CustomExpansionTileUserWidgetState();
}

class _CustomExpansionTileUserWidgetState extends State<CustomExpansionTileUserWidget> {
  late TextEditingController streetName;
  late TextEditingController address;
  late String location;
  late TextEditingController phone;
  late TextEditingController mark;

  @override
  void initState() {
    streetName=TextEditingController(text: widget.addressModelData.name??'');
    address=TextEditingController(text: widget.addressModelData.address??'');
    location= '${widget.addressModelData.lat??''}/${widget.addressModelData.lng??''}';
    phone=TextEditingController(text: widget.addressModelData.phone??'');
    mark=TextEditingController(text: widget.addressModelData.note??'');
    super.initState();
  }
  AddressLocationModel? addressLocation;
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
        title: Text('${widget.addressModelData.name??''}',
            style: TextStyle(
                fontFamily: 'Lateef',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold)),
        children: <Widget>[
          Text(
            getLang(context, 'street_name'),
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500),
          ),
          TextField(
              controller:streetName,
              decoration: InputDecoration(
                  hintText: '',
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
              controller:address,
              decoration: InputDecoration(
                  hintText: '',
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context)=>
                      CustomGoogleMapScreen(
                        onMap: (AddressLocationModel addressLocationModel){
                          setState(() {
                            location ='${addressLocationModel.country},${addressLocationModel.bigCity},${addressLocationModel.city},${addressLocationModel.locality},${addressLocationModel.street}' ;
                            addressLocation =addressLocationModel;
                          });
                        },
                lat:addressLocation!=null?double.parse(addressLocation!.lat!):
                widget.addressModelData.lat!=null&&widget.addressModelData.lat!.isNotEmpty?
                double.parse(widget.addressModelData.lat!):cubit.lat??0.0,
                 long:
                 addressLocation!=null?double.parse(addressLocation!.long!):
                 widget.addressModelData.lng!=null&&widget.addressModelData.lng!.isNotEmpty?
                    double.parse(widget.addressModelData.lng!):cubit.long??0.0,
                type: 'userAddressUpdate',
              )));
            },
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: location,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  color: Color(0xff4B4B4B),
                ),
              ),
              style: TextStyle(
                color: Colors.black,
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
              controller:phone,
              decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: 'Lateef',
                      color: Color(0xff4B4B4B)))),
          SizedBox(height: 25.h),
          Text(
            getLang(context, 'special_marque'),
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500),
          ),
          TextField(
              controller:mark,
              decoration: InputDecoration(
                  hintText: '',
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
                  AddressModelData newAddressModelData =AddressModelData(
                    id:int.parse('${widget.addressModelData.id}'),
                    name: streetName.text,
                    address: address.text,
                    lat: cubit.addressLocationModelUpdate?.lat??widget.addressModelData.lat,
                    lng: cubit.addressLocationModelUpdate?.long??widget.addressModelData.lng,
                    phone: phone.text,
                    note: mark.text,
                    userId: widget.addressModelData.userId,
                  );
                  cubit.editAddressUser(widget.addressModelData,newAddressModelData, AuthCubit.get(context).token, context).then((value) {
                  });
                }, buttonText: getLang(context, 'update_data')),
          ),
          cubit.isAddLoading?Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(child: CircularProgressIndicator(),),
          ):CustomElevatedButton(
              onTap: () {
                 cubit.deleteAddressUser(int.parse('${widget.addressModelData.id}'), AuthCubit.get(context).token, context);
              },
              buttonText: getLang(context, 'delete_address'),
              backgroundColor: Colors.white,
              borderColor: Colors.black),
        ]);
  },
);
  }
}
