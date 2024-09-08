import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/myorders/logic/my_orders_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_loading2_widget.dart';
import '../../../../../core/functions/date_formatter.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../shared_screens/visitor_screen/widget/visitor_dailog.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../menu/logic/menu_cubit.dart';
import '../../data/model/check_car_model.dart';
import '../../data/model/my_supplies_model.dart';

class SuppliesDetailsScreen extends StatelessWidget {
  final MySuppliesModelData mySuppliesModelData;
   SuppliesDetailsScreen({Key? key, required this.mySuppliesModelData}) : super(key: key);
  int paymentMethod =0;
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit= AuthCubit.get(context);
    MenuCubit menuCubit= MenuCubit.get(context);
    bool x =cubit.localeLanguage==Locale('en');
    DateTime originalDate = DateTime.parse(mySuppliesModelData.suppliesPackage?.createdAt??'');
    String date= formatDate(originalDate, context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: getLang(context, 'package_details'), hasBackButton: true),
        preferredSize: Size(double.infinity, 70.h),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              getLang(context, 'details'),
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            Container(
              height: 100.h,
              margin: EdgeInsets.only(top: 16.h),
              decoration: BoxDecoration(
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular( x?0:10.r),
                        bottomRight: Radius.circular(x?0:10.r),
                        topLeft: Radius.circular( x?10:0.r),
                        bottomLeft: Radius.circular(x?10:0.r),
                    ),
                    child: Container(
                      // padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: packagesColor),
                      child: Image.network(
                        mySuppliesModelData.suppliesPackage?.image??'',
                        height: double.infinity,
                        width: 120.w,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context,Object error,StackTrace? r){
                          return Center(child: Text('waiting....'));

                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 11.w),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 5.h),
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mySuppliesModelData.suppliesPackage?.name??'',
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            mySuppliesModelData.suppliesPackage?.description??'',
                            style: TextStyle(
                              fontWeight: FontWeightManager.regular,
                              fontSize: 14.sp,
                              color: Colors.grey.shade600
                            ),
                          ),
                          Text(
                            '${date}',
                            style: TextStyle(
                              fontWeight: FontWeightManager.regular,
                              fontSize: 14.sp,
                                color: Colors.grey.shade600
                            ),
                          ),
                          Text(
                            '${mySuppliesModelData.suppliesPackage?.price??''} ${getLang(context, 'rs')}',
                            style: TextStyle(
                                fontWeight: FontWeightManager.regular,
                                fontSize: 16.sp,
                                color:Colors.red
                            ),
                          ) ,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: x?5:28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    getLang(context, 'package_duration'),
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
                  ),
                  Text('${getLang(context, 'start_from')} ${DateFormatter.formatDayMonthDate(mySuppliesModelData.suppliesPackage?.createdAt??'', context)} ${getLang(context, 'to')} ${DateFormatter.formatDayMonthDateWithTime(mySuppliesModelData.suppliesPackage?.createdAt??'',mySuppliesModelData.suppliesPackage?.duration??'0', context)} ',
                      style: TextStyle(fontSize: 14.sp))
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: x?5:28.w),
              child: Row(
                children: <Widget>[
                  Text(
                    getLang(context, 'payment_method'),
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff6E6D71)),
                  ),
                  SizedBox(width: 20.w),
                  SvgPicture.asset('assets/icons/mastercard.svg'),
                  SizedBox(width: 10.w),
                  Image.asset(ImagesManager.visa),
                  SizedBox(width: 15.w),
                  // Text('${getCheckCarsModelData.paymentMethod}',
                  //     style: TextStyle(
                  //         fontSize: 14.sp, fontWeight: FontWeight.w400))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 16.h, left: x?5:28.w),
              child: Row(
                children: <Widget>[
                  Text(
                    getLang(context, 'order_value'),
                    style: TextStyle(fontSize: 14.sp, color:  Color(0xff6E6D71)),
                  ),
                  SizedBox(width: 28.w),
                  Text('${mySuppliesModelData.suppliesPackage?.price??''} ${getLang(context, 'rs')}', style: TextStyle(fontSize: 14.sp))
                ],
              ),
            ),
            Divider(
              height: 20.h,
              thickness: 1,
              color: greyColor,
            ),
            SizedBox(height: 16.h),
            Row(
              children: <Widget>[
                Text(getLang(context, 'total_price'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(width: 27.w),
                Text(
                  '${mySuppliesModelData.suppliesPackage?.price??''} ${getLang(context, 'rs')}',
                  style: TextStyle(fontSize: 16.sp, color:Colors.red),
                )
              ],
            ),
          if( mySuppliesModelData.paymentStatus=='paid')
            Container(
              margin: EdgeInsets.symmetric(vertical: 30.h),
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue)
              ),
              child: Center(
                child: Text('${getLang(context, 'paid')}',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                    ),
              ),
              ))
            else
          BlocConsumer<MenuCubit,MenuState>(builder: (BuildContext context,MenuState state){
          return
            menuCubit.paymentVisibilityModel!=null?
           ( menuCubit.paymentVisibilityModel!.data!.visibility==1?
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: CustomElevatedButton(
                  onTap: () {
                    if(AuthCubit.get(context).token.isNotEmpty){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              height: 300.h,
                              width: 343.w,
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                    ),),
                                  Text(
                                    getLang(context, 'payment_method'),
                                    style:
                                    TextStyle(
                                        fontFamily: FontConstants.lateefFont,
                                        fontSize: 30.sp,
                                        color: blackTextColor,
                                        fontWeight: FontWeight.w500
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                  StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState)
                                  {
                                    return Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Image.asset(ImagesManager.visa),
                                                SizedBox(width: 5.w,),
                                                Text(getLang(context, 'visa'),
                                                  style:   TextStyle(
                                                      fontFamily: FontConstants.lateefFont,
                                                      fontSize: 20,
                                                      color: blackTextColor,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Radio<int>(
                                              value: 0,
                                              groupValue: paymentMethod,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  paymentMethod = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        //payment
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Image.asset(ImagesManager.card2),
                                                SizedBox(width: 5.w,),
                                                Text(getLang(context, 'master_card'),
                                                  style:   TextStyle(
                                                      fontFamily: FontConstants.lateefFont,
                                                      fontSize: 20,
                                                      color: blackTextColor,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Radio<int>(
                                              value: 1,
                                              groupValue: paymentMethod,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  paymentMethod = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        BlocConsumer<MyOrdersCubit, MyOrdersState>(
                                          listener: (BuildContext context, MyOrdersState state) {},
                                          builder: (BuildContext context, MyOrdersState state)
                                          {
                                            MyOrdersCubit myOrderCubit =MyOrdersCubit.get(context);
                                            return Column(
                                              children: <Widget>[
                                                state is PaymentLoadingState?Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                                  child: Center(child: CustomLoading2Widget(color: primaryColor),),
                                                ):
                                                CustomElevatedButton(
                                                    onTap: (){
                                                      myOrderCubit.paySuppliesOrder(mySuppliesModelData.id??0,context);
                                                      // Navigator.pop(context);
                                                      // BookPackageCubit.get(context).sendCheckCar(checkCarModel, context).then((value) {});
                                                    },
                                                    buttonText: getLang(context, 'ok'))
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }),

                                ],
                              )
                              ,
                            ),

                          );
                        },
                      );
                    }
                    else{
                      visitorDialog(context);
                      // showToast(text: getLang(context, 'Log_in_first'),state: ToastStates.error, context: context);
                    }
                  }, buttonText:  getLang(context, 'sure'))
            )
               :SizedBox.shrink()):SizedBox.shrink();
          }, listener: (BuildContext context,MenuState state){}),
            SizedBox(height: 40.h,)

          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date,BuildContext context) {
    DateFormat formatter = DateFormat('dd MMMM yyyy', AuthCubit.get(context).localeLanguage.toString());
    return formatter.format(date);
  }
}
