import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../../widgets/custom_material_button.dart';
import '../../data/models/provider_order_model.dart';
import '../../logic/provider_orders_cubit.dart';
import '../widgets/custom_product_widget.dart';

class OrderDetailsProviderScreen extends StatelessWidget {
  const OrderDetailsProviderScreen({Key? key, required this.providerOrderModelData, this.isAccess}) : super(key: key);
  final ProviderOrderModelData providerOrderModelData;
  final bool? isAccess;
  @override
  Widget build(BuildContext context) {
    ProviderOrdersCubit cubit =ProviderOrdersCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: '${getLang(context, 'my_requests')}',hasBackButton: true),
        preferredSize: Size(double.infinity, 70.h),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:   EdgeInsets.only(top: 24.h,right: 16.w),
                  child: Text(
                    getLang(context, 'order_details'),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'order_id')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        '${providerOrderModelData.id.toString()}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'user_name')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        providerOrderModelData.user!.name!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'user_email')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        providerOrderModelData.user!.email!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'user_phone')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        providerOrderModelData.user!.phone!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'total-price')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        '${providerOrderModelData.totalPrice!.toString()} ${getLang(context, 'rs')}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: redColor,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'status')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        '${getLang(context, '${providerOrderModelData.status!}')}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'the_address')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text('${providerOrderModelData.userAddress!.name!}/${providerOrderModelData.userAddress!.address!}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                providerOrderModelData.paymentStatus=='paid'?
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'payment_status')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        '${getLang(context, '${providerOrderModelData.paymentStatus!}')}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ):SizedBox.shrink(),
                providerOrderModelData.paymentStatus=='paid'?
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'payment_method')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        '${providerOrderModelData.paymentMethod!}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: blackTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ):SizedBox.shrink(),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return CustomProductWidgetOrderProvider(items: providerOrderModelData.items![index], status:providerOrderModelData.status!,);
                    },
                    itemCount: providerOrderModelData.items!.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
          isAccess ==true?Positioned(
              bottom: 0,
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    providerOrderModelData.paymentStatus!='paid'?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        providerOrderModelData.status!='accepted'?
                        CustomMaterialButton(
                          color: Colors.green.shade300,
                          text: '${getLang(context, 'accept')}', onPressed: () {
                          CustomDialogs.showAlertDialog(
                            type: DialogType.success,
                            btnOkOnPress: () {
                              cubit.acceptOrder(providerOrderModelData.id!,context);
                            },
                            ctx: context,
                            btnCancelOnPress: () {},
                            title: '${getLang(context, 'acc_title')}',
                            desc: '${getLang(context, 'acc_mes')}',
                            btnOkText: '${getLang(context, 'yes')}',
                            btnCancelText: '${getLang(context, 'no')}',
                          );

                        },):SizedBox.shrink(),
                        providerOrderModelData.status!='accepted'?SizedBox(width: 16,):SizedBox.shrink(),
                        providerOrderModelData.status!='rejected'?
                        CustomMaterialButton(
                          color: Colors.red,
                          text: '${getLang(context, 'reject')}', onPressed: () {
                          CustomDialogs.showAlertDialog(
                            type: DialogType.error,
                            btnOkOnPress: () {
                              cubit.rejectOrder(providerOrderModelData.id!,context);
                            },
                            ctx: context,
                            btnCancelOnPress: () {},
                            title: '${getLang(context, 'rej_title')}',
                            desc: '${getLang(context, 'rej_mes')}',
                            btnOkText: '${getLang(context, 'yes')}',
                            btnCancelText: '${getLang(context, 'no')}',
                          );

                        },):SizedBox.shrink(),
                        SizedBox(width: 16,),
                        providerOrderModelData.status!='cancelled'?
                        CustomMaterialButton(
                          color: Colors.grey,
                          text: '${getLang(context, 'cancel')}', onPressed: () {
                          CustomDialogs.showAlertDialog(
                            type: DialogType.warning,
                            btnOkOnPress: () {
                              cubit.cancelOrder(providerOrderModelData.id!,context);
                            },
                            ctx: context,
                            btnCancelOnPress: () {},
                            title: '${getLang(context, 'cancel_title')}',
                            desc: '${getLang(context, 'cancel_mes')}',
                            btnOkText: '${getLang(context, 'yes')}',
                            btnCancelText: '${getLang(context, 'no')}',
                          );

                        },):SizedBox.shrink(),
                      ],
                    ):SizedBox.shrink(),
                    SizedBox(height: 10,),
                    providerOrderModelData.paymentStatus=='paid'?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        providerOrderModelData.status!='preparing'?
                        CustomMaterialButton(
                          textColor:Colors.black54,
                          text: '${getLang(context, 'preparing2')}', onPressed: () {
                          CustomDialogs.showAlertDialog(
                            type: DialogType.warning,
                            btnOkOnPress: () {
                              cubit.preparingOrder(providerOrderModelData.id!,context);
                            },
                            ctx: context,
                            btnCancelOnPress: () {},
                            title: '${getLang(context, 'prep_title')}',
                            desc: '${getLang(context, 'prep_mes')}',
                            btnOkText: '${getLang(context, 'yes')}',
                            btnCancelText: '${getLang(context, 'no')}',
                          );
                        },):SizedBox.shrink(),
                        SizedBox(width: 16,),
                        providerOrderModelData.status!='delivered'?
                        CustomMaterialButton(
                          textColor:Colors.black54,
                          text: '${getLang(context, 'deliver')}', onPressed: () {
                          CustomDialogs.showAlertDialog(
                            type: DialogType.warning,
                            btnOkOnPress: () {
                              cubit.deliveredOrder(providerOrderModelData.id!,context);
                            },
                            ctx: context,
                            btnCancelOnPress: () {},
                            title: '${getLang(context, 'del_title')}',
                            desc: '${getLang(context, 'del_mes')}',
                            btnOkText: '${getLang(context, 'yes')}',
                            btnCancelText: '${getLang(context, 'no')}',
                          );

                        },):SizedBox.shrink(),
                      ],
                    ):SizedBox.shrink()
                  ],
                ),
              )):SizedBox.shrink(),
        ],
      ),
    );
  }
}
