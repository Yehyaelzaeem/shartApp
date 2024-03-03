import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_button.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/routing/navigation_services.dart';
import '../../../../../../core/routing/routes.dart';
import '../../features/provider/home/logic/provider_home_cubit.dart';
import 'custom_package_details_screen.dart';


class SubscribePackagesDetailsScreen extends StatelessWidget {
  const SubscribePackagesDetailsScreen({Key? key, this.title, this.list, this.price, required this.id}) : super(key: key);
  final String? title;
  final List<String>? list;
  final String id;
  final String? price;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar( title:  getLang(context, 'packages'),hasBackButton: true)
      ),
      body: Container(
        margin: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children:
                <Widget>[
                  Container(
                    height: 95.h,
                    width: double.infinity,
                    color: Color(0xffF9F7EE),
                    child: Center(
                        child: FittedBox(
                          child: Text('${title}',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontFamily: FontConstants.lateefFont,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        )),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 77.h, bottom: 100.h),
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        width: double.infinity,
                        height: 32.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                            color:
                            i % 2 != 0 ? whiteColor : Color(0xffF9F7EE)),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(IconsManager.trueIcon),
                            SizedBox(width: 8.w),
                            Text('${list![i]}')
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: list!.length,
                  ),
                  SizedBox(height: 80.h,),
                  BlocConsumer<ProviderHomeCubit, ProviderHomeState>(
                      listener: (BuildContext context,ProviderHomeState state) {},
                      builder: (BuildContext context, ProviderHomeState state) {
                        return
                          ProviderHomeCubit.get(context).isLoading==true?
                          Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Center(child: CircularProgressIndicator(),),
                        ):
                         Padding(padding: EdgeInsets.symmetric(horizontal: 16.w),
                                        child: CustomElevatedButton(
                                            onTap: () {
                                               ProviderHomeCubit.get(context).subscribePackages(id, context);
                                              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CustomPackageDetailsScreen()));
                                            },
                                            buttonText: getLang(context, 'subscribe_now')),
                                      );
                      },
                    ),
                  SizedBox(height: 80.h,)
                ],
              ),
            ),
            Positioned(
              top: 70.h,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircleAvatar(
                    radius: 44.sp,
                    child: CircleAvatar(
                      radius: 40.sp,
                      backgroundColor: Color(0xffF9F7EE),
                      child: Text(
                        '${price}\n ${getLang(context, 'rs')}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeightManager.bold,
                          fontFamily: FontConstants.lateefFont,
                          color: blackColor,
                        ),
                      ),
                    ),
                    backgroundColor: whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
