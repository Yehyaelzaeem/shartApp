import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/localization/appLocale.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../core/resources/color.dart';
import '../../profile/logic/provider_profile_cubit.dart';
import '../../profile/presentation/complete_profile/widgets/custom_complete_body.dart';

class CustomEditStoreBody extends StatelessWidget {
  const CustomEditStoreBody({super.key, this.isEdit});
  final bool? isEdit;
  @override
  Widget build(BuildContext context) {
    ProviderProfileCubit cubit = ProviderProfileCubit.get(context);
    isEdit==true?cubit.displayDataOfScreen():null;
    return SingleChildScrollView(
      child: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
        listener: (BuildContext context,ProviderProfileState state) {},
        builder: (BuildContext context, ProviderProfileState state) {
          var data =cubit.providerProfileModel!.data!;
          return
            cubit.isUpdateEditingLoading==false?
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${getLang(context, 'attach_store_logo')}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5.h,),
              Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(data.logo!),
                ),
              ),
              Divider(color: Colors.grey.shade300,),
              Text(
                getLang(context, 'store_name'),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                enabled: false,
                  controller:TextEditingController() ,
                  decoration: InputDecoration(
                      hintText: '${data.storeName}',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          fontFamily: 'Lateef',
                          color: Color(0xff4B4B4B)))),

              SizedBox(height: 25.h),
              Text(
                getLang(context, 'commercial_no'),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                  enabled: false,
                  controller:TextEditingController() ,
                  decoration: InputDecoration(
                      hintText:
                      '${data.commercialRegistrationNo}',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          fontFamily: 'Lateef',
                          color: Color(0xff4B4B4B)))),
              SizedBox(height: 25.h),
              Text(
                getLang(context, 'main_address'),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),

              TextField(
                  enabled: false,
                  controller:TextEditingController(),
                  decoration: InputDecoration(
                      hintText: '${data.mainAddress}',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          fontFamily: 'Lateef',
                          color: Color(0xff4B4B4B)))),
              SizedBox(height: 25.h),
              Text(
                getLang(context, 'bank_account_number'),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),

              TextField(
                  enabled: false,
                  controller:TextEditingController(),
                  decoration: InputDecoration(
                      hintText: '${data.ipan}',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          fontFamily: 'Lateef',
                          color: Color(0xff4B4B4B)))),
              SizedBox(height: 25.h),
              Text(
                getLang(context, 'record_expiration_date'),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),

              TextField(
                  enabled: false,
                  controller:TextEditingController(),
                  decoration: InputDecoration(
                      hintText: '${data.commercialEndDate}',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          fontFamily: 'Lateef',
                          color: Color(0xff4B4B4B)))),
              SizedBox(height: 25.h),
              Text(
                getLang(context, 'add_commercial_file'),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5.h,),
              Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:Icon(Icons.picture_as_pdf,color: Colors.blue.shade300,)
                ),
              ),
              Divider(color: Colors.grey.shade300,),
              SizedBox(height: 25.h),
              Text(
                getLang(context, 'add_identity'),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5.h,),
              Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(data.nationalIdImage!),
                ),
              ),
              Divider(color: Colors.grey.shade300,),
              SizedBox(height: 25.h),
              CustomElevatedButton(onTap: () {
                cubit.changeUpdateEditingLoading(true);
              }, buttonText: '${getLang(context, 'edit')}'),
              SizedBox(height: 150.h,),
            ],
          ):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 30.w,
                color: Colors.white,
                child: Center(
                  child: IconButton(
                    onPressed: (){
                      cubit.changeUpdateEditingLoading(false);
                    },
                    icon: Icon(Icons.clear,
                      color: blueColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              CustomCompleteProfileBody(),
            ],
          );
        },
      ),
    );
  }
}
