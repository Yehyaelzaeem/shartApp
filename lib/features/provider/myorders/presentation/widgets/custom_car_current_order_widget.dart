import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../user/myorders/data/model/check_car_model.dart';
import '../../../../user/myorders/presentation/screens/report_screen.dart';

class CustomCarCurrentOrderWidget extends StatelessWidget {
  const CustomCarCurrentOrderWidget({super.key, required this.getCheckCarsModelData});
final GetCheckCarsModelData getCheckCarsModelData;
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
              ReportScreen(getCheckCarsModelData: getCheckCarsModelData,)));
        // NavigationManager.push(Routes.orderDetails);
      },
      child: Container(
        height: 100.h,
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r)),
              child: Container(
                padding: const EdgeInsets.all(0.0),
                width: 134.w,
                height: 100.h,
                decoration: BoxDecoration(color: packagesColor),
                child: Image.network(
                  getCheckCarsModelData.package!.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (context,error,v){
                    return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
                  },
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 88.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 20.h,
                    child: FittedBox(
                      child: Text(
                        getCheckCarsModelData.package!.title!,
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                      ),
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
            SizedBox(width: 35.w),
            Container(
              width: 63.w,
              height: 30.h,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50.r)
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    '${getLang(context, '${getCheckCarsModelData.status}')}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
