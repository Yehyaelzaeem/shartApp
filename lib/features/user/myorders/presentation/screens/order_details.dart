import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_material_button.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../provider/work_and_products/data/model/product_model.dart';
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
        preferredSize: Size(double.infinity, 80.h),
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
                  children: [
                    Text(
                      getLang(context, 'order_details'),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    myOrdersModelData.status !='cancelled'&&myOrdersModelData.status !='delivered' && myOrdersModelData.status !='rejected'?
                    CustomMaterialButton(text: '${getLang(context, 'cancel')}', onPressed: (){
                      MyOrdersCubit.get(context).cancelOrderUser(myOrdersModelData.id!, context);
                    }):
                    SizedBox.shrink()
                  ],
                ),
              ),
              Padding(
                padding:   EdgeInsets.only(top: 0.h,right: 16.w),
                child:
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
                  children: [
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
                  children: [
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
                  children: [
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
                  children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
