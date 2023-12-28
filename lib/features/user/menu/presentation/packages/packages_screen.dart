import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/user/menu/logic/menu_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../packages_details/package_details_screen.dart';


class CarPackagesCheckScreen extends StatefulWidget {
  const CarPackagesCheckScreen({Key? key}) : super(key: key);

  @override
  State<CarPackagesCheckScreen> createState() => _CarPackagesCheckScreenState();
}

class _CarPackagesCheckScreenState extends State<CarPackagesCheckScreen> {
  @override
  Widget build(BuildContext context) {
    MenuCubit cubit =MenuCubit.get(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: getLang(context, 'packages'),hasBackButton: true)
      ),
      body: BlocConsumer<MenuCubit,MenuState>(
        builder: (BuildContext context ,MenuState state){
          return   MenuCubit.get(context).packageCheckModel !=null?
          ListView.builder(
              itemCount: cubit.packageCheckModel!.data!.length,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:   Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: packagesColor,
                        border: Border.all(color: Color.fromRGBO(161, 161, 161, 0.20)),
                        borderRadius: BorderRadius.circular(10.r)),
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${cubit.packageCheckModel!.data![index].title}',
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontFamily: FontConstants.lateefFont,
                                fontWeight: FontWeightManager.bold,
                                color: blackColor)),
                        Text(
                          getLang(context, 'shart_check_message'),
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.regular,
                              color: Color(0xff414141)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h, top: 9.h),
                          child: Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network('${cubit.packageCheckModel!.data![index].image}',fit: BoxFit.cover,))),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            child: Text(
                              getLang(context, 'more_details'),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: FontConstants.lateefFont,
                                  fontWeight: FontWeightManager.bold,
                                  color:  Colors.black
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CarCheckPackagesDetailsScreen(index:index)));
                              // NavigationManager.push(Routes.checkingPackagesDetails);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 18.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):
          Center(child: CircularProgressIndicator(),);
        },
        listener: (BuildContext context ,MenuState state){},
      )

      /*
      Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: packagesColor,
                border: Border.all(color: Color.fromRGBO(161, 161, 161, 0.20)),
                borderRadius: BorderRadius.circular(10.r)),
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('فحص شرط'.tr(),
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: FontConstants.lateefFont,
                        fontWeight: FontWeightManager.bold,
                        color: blackColor)),
                Text(
                  'يشمل فحص شرط على تقرير عن حالة المركبة'.tr(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.regular,
                      color: Color(0xff414141)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h, top: 9.h),
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(ImagesManager.fixCar2)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    child: Text(
                      'تفاصيل أكثر'.tr(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontConstants.lateefFont,
                        fontWeight: FontWeightManager.bold,
                        color:  Colors.black
                      ),
                    ),
                    onPressed: () {
                      NavigationManager.push(Routes.checkingPackagesDetails);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 18.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: packagesColor,
                border: Border.all(color: Color.fromRGBO(161, 161, 161, 0.20)),
                borderRadius: BorderRadius.circular(10.r)),
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('فحص شرط بلس'.tr(),
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: FontConstants.lateefFont,
                        fontWeight: FontWeightManager.bold,
                        color: blackColor)),
                Text(
                  'يشمل فحص شرط بلس على تقرير عن حالة المركبة .......'.tr(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.regular,
                      color: Color(0xff414141)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 22.h, bottom: 21.h),
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(ImagesManager.car2)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    child: Text(
                      'تفاصيل أكثر'.tr(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontConstants.lateefFont,
                        fontWeight: FontWeightManager.bold,
                          color:  Colors.black

                      ),
                    ),
                    onPressed: () {
                      NavigationManager.push(Routes.checkingPackagesDetails);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 18.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),

       */
    );
  }
}
