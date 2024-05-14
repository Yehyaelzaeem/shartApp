import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/provider/profile/logic/provider_profile_cubit.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../../widgets/custom_menu_top_log_widget.dart';
import '../../../../../widgets/custom_slider_widget.dart';
import '../../../../../widgets/custom_title_tab_bar.dart';
import '../../../../../widgets/custom_welcome_message.dart';
import '../../../../user/menu/logic/menu_cubit.dart';
import '../../../myorders/logic/provider_orders_cubit.dart';
import '../widgets/custom_cancelled _orders_home.dart';
import '../widgets/custom_complete_row_widget.dart';
import '../widgets/custom_current_orders_home.dart';
import '../widgets/custom_previous _orders_home.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);
  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}
class _ProviderHomeScreenState extends State<ProviderHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ProviderOrdersCubit cubit=  ProviderOrdersCubit.get(context);
    return RefreshIndicator(child:
    PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        CustomDialogs.showAlertDialog(
          type: DialogType.warning,
          btnOkOnPress: () {
            exit(0);
          },
          ctx: context,
          btnCancelOnPress: () {},
          title: '${getLang(context, 'exit')}',
          desc: '${getLang(context, 'sure_exit')}',
          btnOkText: '${getLang(context, 'yes')}',
          btnCancelText: '${getLang(context, 'no')}',
        );
        // NavigationManager.pushReplacement(Routes.login);
      },
      child:  NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            cubit.limit=cubit.limit+10;
            cubit.fetchOrdersCurrentProvider(context,cubit.limit,true);
          }
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              // physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30.h,),
                  CustomTopRowLogo(type: 'provider',),
                  CustomWelcomeMessage(),
                  CustomSliderWidget(),
                  // CustomSubscribeWidget(),
                  Center(
                    child: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
                        listener: (BuildContext context,ProviderProfileState state) {},
                        builder: (BuildContext context,ProviderProfileState state) {
                          if(ProviderProfileCubit.get(context).providerProfileModel!=null){
                            if(ProviderProfileCubit.get(context).providerProfileModel!.data!.profileCompleted==false) {
                              return CustomCompleteWidgetRow();
                            }
                            else{
                              return SizedBox.shrink();
                            }
                          }
                          // if(ProviderProfileCubit.get(context).providerProfileModel!=null){
                          //   // if(ProviderProfileCubit.get(context).providerProfileModel!.data!.currentSubscription==null){
                          //   //   return CustomSubscribeWidgetRow();
                          //   // }
                          //   if(ProviderProfileCubit.get(context).providerProfileModel!.data!.profileCompleted==false
                          //       && ProviderProfileCubit.get(context).providerProfileModel!.data!.currentSubscription==null
                          //   ){
                          //     // return CustomSubscribeWidgetRow();
                          //     return  Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //       children: <Widget>[
                          //         CustomCompletePaperWidget(),
                          //         CustomSubscribeWidget(),
                          //       ],
                          //     );
                          //   }else if(
                          //   ProviderProfileCubit.get(context).providerProfileModel!.data!.profileCompleted==false &&
                          //       ProviderProfileCubit.get(context).providerProfileModel!.data!.currentSubscription!=null)
                          //   {
                          //     return CustomCompleteWidgetRow();
                          //   }else if(
                          //   ProviderProfileCubit.get(context).providerProfileModel!.data!.profileCompleted==true &&
                          //       ProviderProfileCubit.get(context).providerProfileModel!.data!.currentSubscription==null)
                          //   {
                          //     return CustomSubscribeWidgetRow();
                          //   }
                          //   else{
                          //     return SizedBox.shrink();
                          //   }
                          // }
                          else{
                            return SizedBox.shrink();
                          }
                        }
                    ),
                  ),
                  TabBar(
                    controller: controller,
                    onTap: (int val) {
                      setState(() {
                      });
                    },
                    tabs: <Widget>[
                      CustomTitleTabBarWidget(title: '${getLang(context, 'current_orders')}',),
                      CustomTitleTabBarWidget(title: '${getLang(context, 'previous_orders')}',),
                      CustomTitleTabBarWidget(title: '${getLang(context, 'canceled_orders')}',),
                    ],
                    labelColor: Color(0xff136B79),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Color(0xff136B79),

                    labelStyle: TextStyle(fontSize: 16.sp, fontFamily: 'Lateef'),
                    // indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  if(controller.index==0)
                    CustomCurrentOrderHomeWidget(),
                  if(controller.index==1)
                    CustomPreviousOrderHomeWidget(),
                  if(controller.index==2)
                    CustomCancelledOrderHomeWidget(),
                  SizedBox(height: 0.h),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
        onRefresh: ()async{
          await Future.delayed(Duration(seconds: 1));
          cubit.putNull();
          MenuCubit.get(context).getBanners('provider',context);
         cubit.fetchOrdersCurrentProvider(context,10,true);
         cubit.getMyOrdersPreviousProvider(context);
         cubit.getMyOrdersCancelledProvider(context);
        });

  }
}
