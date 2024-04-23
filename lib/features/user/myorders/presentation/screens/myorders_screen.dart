import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/features/user/myorders/data/model/myorder_model.dart';
import 'package:shart/features/user/myorders/logic/my_orders_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../shared_screens/visitor_screen/visitor_screen.dart';
import '../../../../../widgets/custom_title_tab_bar.dart';
import '../../../../provider/myorders/presentation/widgets/custom_car_cancelled_order_widget.dart';
import '../../../../provider/myorders/presentation/widgets/custom_car_current_order_widget.dart';
import '../../../../provider/myorders/presentation/widgets/custom_order_invoice_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav_screen.dart';
import '../widgets/order_widgets.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({Key? key, this.isNotNotification, this.initialIndex}) : super(key: key);
  final bool? isNotNotification;
  final int? initialIndex;

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}
class _UserOrdersScreenState extends State<UserOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    if(widget.initialIndex!=null){
      tabController = TabController(length: 2, vsync: this,initialIndex: widget.initialIndex!);
    }else{
      tabController = TabController(length: 2, vsync: this);
    }
  }
  @override
  Widget build(BuildContext context) {
    widget.isNotNotification!=true?
    MyOrdersCubit.get(context).getMyOrder(context):null;
    MyOrdersCubit myOrdersCubit =MyOrdersCubit.get(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => UserBottomNavScreen(
              checkPage: '0',
            )));
      },
      child:
      AuthCubit.get(context).token.isEmpty?
      CustomVisitorScreen():
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, 70.h),
              child: CustomAppBar(title: '${getLang(context, 'my_requests')}')),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.h),
              Container(
                height: 50,
                child: TabBar(
                  controller: tabController,
                  onTap: (int val) {
                    setState(() {});
                  },
                  tabs: <Widget>[
                    CustomTitleTabBarWidget(title: '${getLang(context, 'spare_parts')}',),
                    CustomTitleTabBarWidget(title: '${getLang(context, 'check_cars')}',),
                  ],
                  // padding: AuthCubit.get(context).localeLanguage==Locale('ar')?EdgeInsets.only(left: 170.w):EdgeInsets.only(right: 120.w),
                  labelStyle: TextStyle(
                      color: Color(0xff136B79),
                      fontSize: 16.sp,
                      fontFamily: 'Lateef'),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Lateef',
                      color: Colors.black),
                  indicatorColor: Color(0xff136B79),
                  labelColor: Color(0xff136B79),
                  // indicatorPadding: EdgeInsets.symmetric(horizontal: 0.w,vertical: ),
                  unselectedLabelColor: Colors.black,
                ),
              ),
              if (tabController.index == 0)
                Expanded(
                  child:
                  RefreshIndicator(child:
                  BlocConsumer<MyOrdersCubit, MyOrdersState>(
                    listener: (BuildContext context,MyOrdersState state) {},
                    builder: (BuildContext context,MyOrdersState state) {
                      if(myOrdersCubit.myOrdersModel!=null){
                        if(myOrdersCubit.myOrdersModel!.data!.length==0){
                          return
                            Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(child: Image.asset(ImagesManager.cart33)),
                                  SizedBox(height: 16.h,),
                                  Text(
                                    getLang(context, 'no_order_now'),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: blackTextColor,
                                        fontFamily: FontConstants.lateefFont,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }
                        else{
                          return SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                ...myOrdersCubit.myOrdersModel!.data!.map((MyOrdersModelData e) {
                                  if(e.status=='pending'){
                                    return buildCurrentOrder(e.items!,e,e.status!,context);
                                  }
                                  else if(e.status=='accepted'){
                                    return buildCurrentOrder(e.items!,e,e.status!,context);
                                  }
                                  else if(e.status=='delivered'){
                                    return buildOrderWithInvoice(e.items!,e,e.status!,context);

                                  }
                                  else if(e.status=='preparing'){
                                    return buildCurrentOrder(e.items!,e,e.status!,context);

                                  }
                                  else{
                                    return buildCancelledOrder(e.items!,e,e.status!,context);
                                  }
                                }).toList(),
                                // ...myOrdersCubit.myOrdersModel!.data![index].items!.map((e) {
                                //       if(myOrdersCubit.myOrdersModel!.data![index].status=='pending'){
                                //         return buildCurrentOrder(e,myOrdersCubit.myOrdersModel!.data![index],myOrdersCubit.myOrdersModel!.data![index].status!,context);
                                //       }
                                //       else if(myOrdersCubit.myOrdersModel!.data![index].status=='accepted'){
                                //         return buildCurrentOrder(e,myOrdersCubit.myOrdersModel!.data![index],myOrdersCubit.myOrdersModel!.data![index].status!,context);
                                //       }
                                //       else if(myOrdersCubit.myOrdersModel!.data![index].status=='delivered'){
                                //         return buildOrderWithInvoice(e,myOrdersCubit.myOrdersModel!.data![index],myOrdersCubit.myOrdersModel!.data![index].status!,context);
                                //
                                //       }else{
                                //         return buildCancelledOrder(e,myOrdersCubit.myOrdersModel!.data![index],myOrdersCubit.myOrdersModel!.data![index].status!,context);
                                //       }
                                // }).toList(),
                              ],
                            ),
                          );
                        }

                        //   ListView.builder(
                        //   physics: BouncingScrollPhysics(),
                        //   itemBuilder: (BuildContext context, int index) {
                        //     if(myOrdersCubit.myOrdersModel!.data![index].status=='pending'){
                        //       return buildCurrentOrder(myOrdersCubit.myOrdersModel!.data![index],context);
                        //     }else if(myOrdersCubit.myOrdersModel!.data![index].status=='accepted'){
                        //       return buildCurrentOrder(myOrdersCubit.myOrdersModel!.data![index],context);
                        //     }else if(myOrdersCubit.myOrdersModel!.data![index].status=='delivered'){
                        //       return buildOrderWithInvoice(context);
                        //
                        //     }else{
                        //       return buildCancelledOrder(context);
                        //
                        //     }
                        //     // if (index == 0) return buildCurrentOrder(context);
                        //     // if (index == 1) return buildCancelledOrder(context);
                        //     // return buildOrderWithInvoice(context);
                        //   },
                        //   itemCount: myOrdersCubit.myOrdersModel!.data!.length,
                        //   shrinkWrap: true,
                        // );
                      }else{
                        return Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Center(child: CircularProgressIndicator(),),
                        );}
                    },
                  ),
                      onRefresh: ()async{
                        await Future.delayed(Duration(seconds: 1));
                        myOrdersCubit.getMyOrder(context);
                      })
                )
              else
                Expanded(
                  child: RefreshIndicator(child:
                  BlocConsumer<MyOrdersCubit, MyOrdersState>(
                    listener: (BuildContext context, MyOrdersState state) {},
                    builder: (BuildContext context, MyOrdersState state) {
                      if(myOrdersCubit.getCheckCarsModel!=null){
                        if(myOrdersCubit.getCheckCarsModel!.data!.length==0){
                          return
                            Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(child: Image.asset(ImagesManager.cart33)),
                                  SizedBox(height: 16.h,),
                                  Text(
                                    getLang(context, 'no_check_car_now'),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: blackTextColor,
                                        fontFamily: FontConstants.lateefFont,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                            );

                        }else{
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              // return CustomCarCurrentOrderWidget();
                              if(myOrdersCubit.getCheckCarsModel!.data![index].status=='review'){
                                return CustomCarCurrentOrderWidget(
                                  getCheckCarsModelData: myOrdersCubit.getCheckCarsModel!.data![index],);
                              }
                              else if(myOrdersCubit.getCheckCarsModel!.data![index].status=='accepted'){
                                return CustomCarCurrentOrderWidget(
                                  getCheckCarsModelData: myOrdersCubit.getCheckCarsModel!.data![index],);
                              }
                              else if(myOrdersCubit.getCheckCarsModel!.data![index].status=='finished'){
                                return CustomOrderWithInvoiceAndReportWidget(
                                  getCheckCarsModelData: myOrdersCubit.getCheckCarsModel!.data![index],);
                              }
                              else{
                                return CustomCarCancelledOrderWidget(
                                  getCheckCarsModelData: myOrdersCubit.getCheckCarsModel!.data![index],);
                              }
                              // if (index == 0) return CustomCarCurrentOrderWidget();
                              // if (index == 1) return CustomCarCancelledOrderWidget();
                              // return CustomOrderWithInvoiceAndReportWidget();
                            },
                            itemCount: myOrdersCubit.getCheckCarsModel!.data!.length,
                            shrinkWrap: true,
                          );
                        }
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                      onRefresh: ()async{
                        await Future.delayed(Duration(seconds: 1));
                        myOrdersCubit.getMyCheckCars(context);
                      })
                 
                )
            ],
          ),
        ),
      ),
    );
  }
}
