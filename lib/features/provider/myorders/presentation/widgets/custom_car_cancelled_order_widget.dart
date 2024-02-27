import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../user/myorders/data/model/check_car_model.dart';
import '../../../../user/myorders/presentation/screens/report_screen.dart';

class CustomCarCancelledOrderWidget extends StatelessWidget {
  const CustomCarCancelledOrderWidget({super.key, required this.getCheckCarsModelData});
  final GetCheckCarsModelData getCheckCarsModelData;

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
            ReportScreen(getCheckCarsModelData: getCheckCarsModelData,)));
        },
      child: Container(
        // height: 80.h,
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius:AuthCubit.get(context).localeLanguage==Locale('en')?
              BorderRadius.only(topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)):
              BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r)),
              child: Container(
                padding: const EdgeInsets.all(0.0),
                width: 134.w,
                height: 100.h,
                decoration: BoxDecoration(color: packagesColor),
                child: Image.network(
                  getCheckCarsModelData.package!.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context,Object error,StackTrace? v){
                    return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
                  },
                ),
              ),
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.only(
            //       topRight: Radius.circular(10.r),
            //       bottomRight: Radius.circular(10.r)),
            //   child: Container(
            //     padding: const EdgeInsets.all(8.0),
            //     width: 134.w,
            //     decoration: BoxDecoration(color: packagesColor),
            //     child: Image.network(
            //       getCheckCarsModelData.package!.image!,
            //       errorBuilder: (BuildContext context,Object error,StackTrace? v){
            //         return Image.asset(ImagesManager.holder,  fit: BoxFit.fill,);
            //       },
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            SizedBox(width: 8.w),
            Container(
              width: 124.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getCheckCarsModelData.package!.title!,
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${getCheckCarsModelData.package!.price!} ${getLang(context, 'rs')}',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
                      fontSize: 16.sp,
                      color: Color(0xffDB3022),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 30.h,
              width:63.w ,
              decoration: BoxDecoration(
                  color: Color(0xffFF0000),
                  borderRadius: BorderRadius.circular(50.r)
              ),
              margin: EdgeInsets.zero,
              child: Center(
                child: FittedBox(
                  child: Text(
                    '${getLang(context, 'canceled')}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: whiteColor,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),



          ],
        ),
      ),
    );
  }
}
