import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/features/user/menu/presentation/menu/widget/custom_services_type_widget.dart';
import 'package:shart/widgets/custom_text_field.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../logic/menu_cubit.dart';

class UserMenuScreen extends StatefulWidget {
  const UserMenuScreen({Key? key}) : super(key: key);

  @override
  State<UserMenuScreen> createState() => _UserMenuScreenState();
}

class _UserMenuScreenState extends State<UserMenuScreen> {
  TextEditingController searchController = TextEditingController();
  CarouselController? carouselController = CarouselController();

  List<String> images = <String>[
    ImagesManager.fixCar2,
    ImagesManager.fixCar2,
    ImagesManager.fixCar2,
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   toolbarHeight: 70.h,
      //   backgroundColor: Colors.white,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(top: 10),
      //     child: Center(
      //       child: Image.asset(
      //         ImagesManager.logoCircle,
      //       ),
      //     ),
      //   ),
      //   leadingWidth: double.infinity,
      //   actions: <Widget>[
      //     InkWell(
      //       onTap: () {
      //         NavigationManager.push(Routes.notifications);
      //       },
      //       child: Padding(
      //         padding: EdgeInsets.only(top: 10, left: 10.w),
      //         child: Lottie.asset('assets/json/notification.json',
      //             width: 30.sp, height: 30.sp),
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.h,),
              Row(
                children: <Widget>[
                      SizedBox(width: 155.w,),
                      Image.asset(
                        ImagesManager.logoCircle,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          NavigationManager.push(Routes.notifications);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, left: 10.w),
                          child: SvgPicture.asset('assets/images/svg/notification.svg')
                          // Lottie.asset('assets/json/notification.json',
                          //     width: 30.sp, height: 30.sp),
                        ),
                      ),
                      SizedBox(width: 16.w,),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 4.h, top: 12.h),
                  child: Text(
                    getLang(context, 'welcome_message'),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeightManager.bold,
                      fontFamily: FontConstants.lateefFont,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: InkWell(
                  onTap: (){
                    NavigationManager.push(Routes.store);
                  },
                  child: CustomTextField(
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                    hintText:  getLang(context, 'hit_message'),
                    enabled: false,
                    hintColor: blackColor,
                    hintFontFamily: FontConstants.lateefFont,
                    controller: searchController,
                    prefixIcon: Icon(Icons.search_outlined, color: greyColor),
                  ),
                ),
              ),
              CarouselSlider(
                carouselController: carouselController,
                items: images
                    .map((String e) => ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            e,
                            fit: BoxFit.fill,
                            width: ScreenUtil().screenWidth - 50,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 163.h,
                  autoPlay: true,
                  reverse: true,
                  viewportFraction: 1,
                  autoPlayAnimationDuration: const Duration(milliseconds: 300),
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    images.asMap().entries.map((MapEntry<int, String> entry) {
                  return GestureDetector(
                    onTap: () => carouselController?.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == entry.key
                              ? primaryColor
                              : Colors.black.withOpacity(0.2)),
                    ),
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Text(
                    getLang(context, 'our_services'),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeightManager.medium,
                      fontFamily: FontConstants.lateefFont,
                    ),
                  ),
                ),
              ),
              CustomServicesTypeWidget(
                onTap: (){
                  NavigationManager.push(Routes.checkingPackages);
                },
                image: ImagesManager.car1,
                text:  getLang(context, 'check_cars'),
                color: carCheckColor,
              ),
              CustomServicesTypeWidget(
                onTap: (){
                  NavigationManager.push(Routes.spareParts);
                },
                image: ImagesManager.oil,
                text:  getLang(context, 'spare_parts'),
                color: carCheckColor2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
