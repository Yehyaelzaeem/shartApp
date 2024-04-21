import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shart/features/user/myorders/presentation/screens/payment_screen.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_material_button.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../data/model/myorder_model.dart';
import '../../logic/my_orders_cubit.dart';
import '../widgets/custom_item_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.myOrdersModelData}) : super(key: key);
 final MyOrdersModelData myOrdersModelData;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: '${getLang(context, 'my_requests')}',hasBackButton: true),
        preferredSize: Size(double.infinity, 70.h),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:   EdgeInsets.only(top: 16.h,right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      getLang(context, 'order_details'),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    myOrdersModelData.status !='cancelled'&&myOrdersModelData.status !='delivered' && myOrdersModelData.status !='rejected' && myOrdersModelData.paymentStatus!='paid'?
                    CustomMaterialButton(text: '${getLang(context, 'cancel')}', onPressed: (){
                      CustomDialogs.showAlertDialog(
                        type: DialogType.warning,
                        btnOkOnPress: () {
                          MyOrdersCubit.get(context).cancelOrderUser(myOrdersModelData.id!, context);
                        },
                        ctx: context,
                        btnCancelOnPress: () {},
                        title: '${getLang(context, 'cancel_title')}',
                        desc: '${getLang(context, 'cancel_mes')}',
                        btnOkText: '${getLang(context, 'yes')}',
                        btnCancelText: '${getLang(context, 'no')}',
                      );

                    }):
                    SizedBox.shrink()
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.only(top: 0.h,right: 16.w),
                child:
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
                    Text(
                      '${myOrdersModelData.id.toString()}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'the_shop')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Text(
                      myOrdersModelData.provider!=null?myOrdersModelData.provider!.name!:'',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${getLang(context, 'order_status')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Text(
                      '${getLang(context, '${myOrdersModelData.status}')}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child: Row(
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
                    Text(
                      myOrdersModelData.totalPrice!.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(right: 16.w),
                child: Row(
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
                      child: Text('${myOrdersModelData.userAddress!.address!}',
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
              ),
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return CustomWidgetOrder(
                    id: myOrdersModelData.id!,
                    items: myOrdersModelData.items![index], status:myOrdersModelData.status!,);
                },
                itemCount: myOrdersModelData.items!.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
              ),
              SizedBox(height: 20.h,),
              myOrdersModelData.status=='accepted'&&myOrdersModelData.paymentStatus=='un_paid'?
              BlocConsumer<CartCubit, CartState>(
                listener: (BuildContext context,CartState state) {},
                builder: (BuildContext context, CartState state) {
                  return
                    CartCubit.get(context).isAddOrderLoading?Center(child: CircularProgressIndicator(),) :
                    CustomElevatedButton(onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder:
                              (BuildContext context)=>
                                  PaymentScreen(myOrdersModelData: myOrdersModelData,)));
                    },
                        buttonText: getLang(context, 'pay'));
                },
              ):SizedBox.shrink(),
              if(myOrdersModelData.status=='accepted'&&myOrdersModelData.paymentStatus=='paid')
                 Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12)
                ),
                child:
                Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 100.w,vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if(myOrdersModelData.paymentMethod=='cash')
                           // Icon(Icons.money,size: 28,)
                           Image.asset(ImagesManager.pay)
                        else if(myOrdersModelData.paymentMethod=='card')
                           Image.asset(ImagesManager.visa)
                          // Icon(LineAwesome.cc_visa,size: 28,)
                        else
                          Icon(LineAwesome.cc_mastercard,size: 28,),
                        SizedBox(width: 8.w,),
                        Text(
                          '${getLang(context, 'paid')}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: FontConstants.lateefFont,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              )
              else
                 SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
