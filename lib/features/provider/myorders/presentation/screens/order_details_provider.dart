import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_material_button.dart';
import '../../../../user/myorders/presentation/widgets/custom_item_widget.dart';
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
        preferredSize: Size(double.infinity, 80.h),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
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
                  children: [
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
                      '${providerOrderModelData.id.toString()}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${getLang(context, 'user_name')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Text(
                      providerOrderModelData.user!.name!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${getLang(context, 'user_email')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Text(
                      providerOrderModelData.user!.email!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${getLang(context, 'user_phone')} :',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: geryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Text(
                      providerOrderModelData.user!.phone!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blackTextColor,
                        fontWeight: FontWeight.w700,
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
                    Text(
                      '${providerOrderModelData.totalPrice!.toString()} ${getLang(context, 'rs')}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: redColor,
                        fontWeight: FontWeight.w700,
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
                        maxLines: 4,
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        providerOrderModelData.status!='accepted'?
                        CustomMaterialButton(
                          color: Colors.green.shade300,
                          text: '${getLang(context, 'accept')}', onPressed: () {
                          cubit.acceptOrder(providerOrderModelData.id!,context);
                        },):SizedBox.shrink(),
                        providerOrderModelData.status!='accepted'?SizedBox(width: 16,):SizedBox.shrink(),
                        providerOrderModelData.status!='rejected'? CustomMaterialButton(
                          color: Colors.red,
                          text: '${getLang(context, 'reject')}', onPressed: () {
                          cubit.rejectOrder(providerOrderModelData.id!,context);
                        },):SizedBox.shrink(),
                        SizedBox(width: 16,),
                        providerOrderModelData.status!='canceled'?
                        CustomMaterialButton(
                          color: Colors.grey,
                          text: '${getLang(context, 'cancel')}', onPressed: () {
                          cubit.cancelOrder(providerOrderModelData.id!,context);

                        },):SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomMaterialButton(
                          textColor:Colors.black54,
                          text: '${getLang(context, 'preparing2')}', onPressed: () {
                          cubit.preparingOrder(providerOrderModelData.id!,context);

                        },),
                        SizedBox(width: 16,),
                        CustomMaterialButton(
                          textColor:Colors.black54,
                          text: '${getLang(context, 'deliver')}', onPressed: () {
                          cubit.deliveredOrder(providerOrderModelData.id!,context);

                        },),
                      ],
                    ),
                  ],
                ),
              )):SizedBox.shrink()
        ],
      ),
    );
  }
}
