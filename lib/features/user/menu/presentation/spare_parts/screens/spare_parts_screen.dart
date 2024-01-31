import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/user/menu/presentation/spare_parts/screens/spare_parts_details_screen.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../../../core/resources/assets_menager.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/routing/routes.dart';
import '../../../../../../core/localization/appLocale.dart';
import '../../../../book_package_service/logic/book_package_cubit.dart';
import '../../../logic/menu_cubit.dart';


class SparePartsScreen extends StatelessWidget {
  const SparePartsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: getLang(context, 'spare_parts'),hasBackButton: true,hasCartButton: true,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                MenuCubit c =MenuCubit.get(context);
                c.searchController.text='';
                c.changeLoadingSearch(false);
                c.restartData();
                BookPackageCubit.get(context).getBrands(type:'spare_parts',context: context);
                c.getProducts(type:'spare_parts',context:context);
               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                   SparePartsDetailsScreen(type: 'spare_parts',)));
                // NavigationManager.push(Routes.sparePartsDetails);
              },
              child: Container(
                margin: EdgeInsets.all(16.w),
                width: double.infinity,
                height: 103.h,
                decoration: BoxDecoration(
                  color: tireColor1,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      ImagesManager.tire2,
                      width: 95.w,
                      height: 75.h,
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      getLang(context, 'spare_parts'),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeightManager.light,
                        fontFamily: FontConstants.lateefFont,
                      ),
                    ),
                    SizedBox(width: 15.w),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                NavigationManager.push(Routes.tiresTypes);
              },
              child: Container(
                margin: EdgeInsets.all(16.w),
                width: double.infinity,
                height: 103.h,
                decoration: BoxDecoration(
                  color: tireColor2.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      ImagesManager.tire1,
                      width: 95.w,
                      height: 75.h,
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      getLang(context, 'tires'),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeightManager.light,
                        fontFamily: FontConstants.lateefFont,
                      ),
                    ),
                    SizedBox(width: 15.w),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () => NavigationManager.push(Routes.carSupplies),
            //   child: Container(
            //     margin: EdgeInsets.all(16.w),
            //     width: double.infinity,
            //     height: 103.h,
            //     decoration: BoxDecoration(
            //       color: tireColor3,
            //       borderRadius: BorderRadius.circular(10.r),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Image.asset(
            //           ImagesManager.oil2,
            //           width: 95.w,
            //           height: 75.h,
            //         ),
            //         SizedBox(width: 15.w),
            //         Text(
            //           getLang(context, 'accessories'),
            //           style: TextStyle(
            //             fontSize: 24.sp,
            //             fontWeight: FontWeightManager.light,
            //             fontFamily: FontConstants.lateefFont,
            //           ),
            //         ),
            //         SizedBox(width: 15.w),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
