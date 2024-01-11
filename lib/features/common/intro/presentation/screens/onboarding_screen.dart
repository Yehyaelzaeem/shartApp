import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/routing/navigation_services.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/shared_preference/shared_preference.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  List<PageViewModel> listPagesViewModel = <PageViewModel>[
    PageViewModel(
      title: 'وأنت فى مكانك',
      body:
          'تطبيق شرط هيوفر لك كل ماتحتاجة لسيارتك من قطع غيار وصيانة بأعلى جودة متاحة .',
      image: Image.asset(ImagesManager.introduction1),
    ),
    PageViewModel(
      title: 'قطع غيار متنوعة',
      body: 'وفرنالك العديد من تجار قطع غيار السياراتفى مكان واحد .',
      image: Image.asset(ImagesManager.introduction2),
    ),
    PageViewModel(
      title: 'أشترى بأمان',
      body:
          'إذا كنت تريد شراء سيارة من أى شخص أو مكان سنقوم بفحصها لك وإخبارك بحالتها بالتفصيل .',
      image: Image.asset(
        ImagesManager.introduction3,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: IntroductionScreen(
          pages: listPagesViewModel,
          onChange: (int val) {
            setState(() {
              currentPage = val;
            });
          },
          scrollPhysics: const BouncingScrollPhysics(),
          showDoneButton: false,
          dotsDecorator: DotsDecorator(
            size: Size.square(10.sp),
            activeSize: Size(30.w, 10.h),
            activeColor: primaryColor,
            color: Colors.black12,
            spacing: EdgeInsets.symmetric(horizontal: 3.w),
            activeShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
          ),
          globalFooter: currentPage == 2
              ?
          Padding(
                  padding: EdgeInsets.only(bottom: 90.h, left: 16.w, right: 16.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: Size.fromHeight(48.h),
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r))),
                    child: const Text('فلنبدأ',
                    style: TextStyle(
                      color: Colors.black
                    ),
                    ),
                    onPressed: () {
                      CacheHelper.saveDate(key: 'onBoarding', value: true);
                      NavigationManager.pushReplacement(Routes.chooseUserScreen);
                    },
                  ),
                )
              : const SizedBox.shrink(),
          nextStyle: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(Colors.transparent)),
          next: currentPage < 2
              ? Padding(
                  padding: EdgeInsets.only(top: 40.h, right: 58.w),
                  child: CircleAvatar(
                    foregroundColor: Colors.transparent,
                    minRadius: 20.sp,
                    backgroundColor: primaryColor,
                    child: const Icon(Icons.keyboard_arrow_left_outlined,
                        color: Colors.black),
                  ),
                )
              : const SizedBox.shrink(),
          showSkipButton: true,
          skip: Padding(
            padding: EdgeInsets.only(top: 40.h, left: 10.w),
            child: Align(
                alignment: Alignment.topLeft,
                child: currentPage < 2
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFFDF58),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r)),
                            elevation: 0,
                            side: const BorderSide(
                              color: primaryColor,
                            )),
                        onPressed: () {
                          CacheHelper.saveDate(key: 'onBoarding', value: true);
                          NavigationManager.pushReplacement(Routes.chooseUserScreen);
                        },
                        child: FittedBox(child: Text('تخطي',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                        ),
                        )))
                    : const SizedBox.shrink()),
          ),
          showNextButton: true,
        ),
      ),
    );
  }
}
