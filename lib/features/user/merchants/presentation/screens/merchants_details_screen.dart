import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../widgets/custom_branch_widget.dart';
import '../widgets/custom_previous_widget.dart';
import '../widgets/custom_product_widget.dart';
import 'custom_mer_detials_screen.dart';

class MerchantsDetailsScreen extends StatefulWidget {
  const MerchantsDetailsScreen({super.key});

  @override
  State<MerchantsDetailsScreen> createState() => _MerchantsDetailsScreenState();
}

class _MerchantsDetailsScreenState extends State<MerchantsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child: CustomAppBar(title: getLang(context, 'merchant_details'),hasBackButton: true),
        ),
        body:
        Column(
          children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CustomMerDetailsScreen()));
              },
              child: Container(
              height: 115.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [BoxShadow(color:Colors.black38,blurRadius: 1 )]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 140.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r)),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 115.h,
                        width: 100.w,
                        decoration: BoxDecoration(color: packagesColor),
                        child: Image.asset(
                          ImagesManager.car2,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context,Object error,StackTrace? v){
                            return Center(child: CircularProgressIndicator(),);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('الثعلب لقطع غيار السيارات',
                          style: TextStyle(
                            fontWeight: FontWeightManager.bold,
                            fontSize: 16.sp,
                            color: blackTextColor,
                          ),
                        ),
                       SizedBox(height: 10.h,),
                       Row(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               SvgPicture.asset(IconsManager.mer1),
                               SizedBox(width: 3.w,),
                               Text(
                                 '15 ${getLang(context, 'product')}',
                                 style: TextStyle(
                                   fontWeight: FontWeightManager.bold,
                                   fontSize: 12.sp,
                                   color: geryTextColor,
                                   fontFamily: FontConstants.Tajawal
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ],
                           ),
                           Spacer(),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               SvgPicture.asset(IconsManager.mer2),
                               SizedBox(width: 3.w,),
                               Text(
                                 '4 ${getLang(context, 'branch')}',
                                 style: TextStyle(
                                   fontWeight: FontWeightManager.bold,
                                   fontSize: 12.sp,
                                   color: geryTextColor,
                                   fontFamily: FontConstants.Tajawal
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ],
                           ),
                           SizedBox(width: 17.w,),

                         ],
                       ),


                      ],
                    ),
                  ),
                ],
              ),
                      ),
            ),
          ),
            TabBar(
              onTap: (int val) {
                setState(() {
                  // print(val);
                });
              },
              tabs: <Widget>[
                Tab(text: '${getLang(context, 'products')}'),
                Tab(text: '${getLang(context, 'previous_work')}'),
                Tab(text: '${getLang(context, 'branch_addresses')}'),
              ],
              labelStyle: TextStyle(
                  color: Color(0xff136B79),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily:FontConstants.Tajawal),
              unselectedLabelStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.Tajawal,
                  color: Colors.black),
              indicatorColor: Color(0xff136B79),
              labelColor: Color(0xff136B79),
             indicatorPadding: EdgeInsets.zero,
              unselectedLabelColor: Colors.black,
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  CustomProductsWidgetTabBar(),
                  CustomPreviousWorkWidgetTabBar(),
                  CustomBranchAddressesWidgetTabBar(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
