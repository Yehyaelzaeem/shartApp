import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../user/myorders/presentation/widgets/custom_item_widget.dart';
import '../../data/models/provider_order_model.dart';
import '../widgets/custom_product_widget.dart';

class OrderDetailsProviderScreen extends StatelessWidget {
  const OrderDetailsProviderScreen({Key? key, required this.providerOrderModelData}) : super(key: key);
  final ProviderOrderModelData providerOrderModelData;
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
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return CustomProductWidgetOrderProvider(items: providerOrderModelData.items![index], status:providerOrderModelData.status!,);
                },
                itemCount: providerOrderModelData.items!.length,
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
