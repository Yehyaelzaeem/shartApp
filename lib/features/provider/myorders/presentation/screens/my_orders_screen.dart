import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/features/provider/myorders/data/models/provider_order_model.dart';
import 'package:shart/features/provider/myorders/logic/provider_orders_cubit.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import 'package:shart/widgets/custom_loading2_widget.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';
import '../widgets/custom_myorders_widget.dart';
import 'order_details_provider.dart';

class ProviderOrdersScreen extends StatelessWidget {
  const ProviderOrdersScreen({Key? key, this.isNotNotification}) : super(key: key);
  final bool? isNotNotification;



  @override
  Widget build(BuildContext context) {
    ProviderOrdersCubit cubit =ProviderOrdersCubit.get(context);
    if(isNotNotification!=true){
      cubit.fetchOrdersCurrentProvider( context,cubit.limit,false);
      cubit.getMyOrdersPreviousProvider(context);
      cubit.getMyOrdersCancelledProvider(context);
    }
    return RefreshIndicator(child:
    PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                ProviderBottomNavScreen(
                  checkPage: '0',
                )));
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            if(cubit.loading!=true){
              cubit.limit=cubit.limit+10;
              cubit.fetchOrdersCurrentProvider(context,cubit.limit,true);
            }
          }
          return false;
        },
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(double.infinity, 70.h),
                child: CustomAppBar(
                  title: '${getLang(context, 'my_requests')}',
                )),

            body:
            BlocConsumer<ProviderOrdersCubit, ProviderOrdersState>(
              listener: (BuildContext context,ProviderOrdersState state) {},
              builder: (BuildContext context, ProviderOrdersState state) {
                if(cubit.myOrdersCurrentList!=null){
                  if(cubit.myOrdersCurrentList!.length==0){
                    return Padding(
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
                  }else{
                    List<ProviderOrderModelData> data =cubit.myOrdersCurrentList!;
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if(index < data.length){
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (BuildContext context)=>OrderDetailsProviderScreen(
                                isAccess: true,
                                providerOrderModelData: data[index],)));
                            },
                            child:
                            Padding(padding:
                            EdgeInsets.only(left: 16.w, right: 16.w,), child:
                            CustomProductMyOrderWidget(
                              providerOrderModelData: data[index] ,),
                            ),
                          );
                        }else{
                          if (index == data.length) {
                            if(cubit.loading==true){
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: CustomLoading2Widget(color: primaryColor,),
                              );
                            }else{
                              return SizedBox();
                              //   Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Center(
                              //     child: Container(
                              //        child: Text(getLang(context, 'all_data'),
                              //          style: TextStyles.font16GeryColor400WeightTajawal,),
                              //     ),
                              //   ),
                              // );
                            }
                          } else {
                            return Container(); }
                        }

                      },
                      itemCount: data.length+1,
                      shrinkWrap: true,
                    );
                  }
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }

              },
            )

        ),)


    ), onRefresh: ()async{
      await Future.delayed(Duration(seconds: 1));
      cubit.putNullCurrent();
      cubit.getMyOrdersCurrentProvider(context,10);
    });

  }
}
