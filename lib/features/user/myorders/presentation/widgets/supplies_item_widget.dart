import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import '../../../../../core/functions/date_formatter.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../user/auth/logic/auth_cubit.dart';
import '../../../../user/myorders/data/model/check_car_model.dart';
import '../../../../user/myorders/presentation/screens/report_screen.dart';
import '../../data/model/my_supplies_model.dart';
import '../screens/supplies_details_screen.dart';

class SuppliesItemWidget extends StatelessWidget {
  final MySuppliesModelData mySuppliesModelData;

  const SuppliesItemWidget({super.key, required this.mySuppliesModelData});
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
              SuppliesDetailsScreen(mySuppliesModelData: mySuppliesModelData,)));
        // NavigationManager.push(Routes.orderDetails);
      },
      child: Container(
        height: 100.h,
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        decoration:
        BoxDecoration(
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
                  mySuppliesModelData.suppliesPackage?.image??'',
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context,Object error,StackTrace? v){
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
                  SizedBox(height: 10),

                  Container(
                    height: 20.h,
                    child: FittedBox(
                      child: Text(
                        mySuppliesModelData.suppliesPackage?.name??'',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                      ),
                    ),
                  ),

                  Spacer(),
                  SizedBox(height: 10),
                  Text(
                    '${mySuppliesModelData.suppliesPackage?.price??''} ${getLang(context, 'rs')}',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '${DateFormatter.formatDateDMY(mySuppliesModelData.suppliesPackage?.createdAt??'',context)}',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
                      fontSize: 10.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),


                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Spacer(),
                mySuppliesModelData.paymentStatus=='paid'?
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${getLang(context, 'paid')}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.blue.shade800,
                          fontFamily: FontConstants.lateefFont,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ),
                  ),
                ):SizedBox.shrink(),
                SizedBox(height: 10.h),

              ],
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
