import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/shared_screens/notifications/data/models/notificationModel.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../logic/notification_cubit.dart';
import '../widgets/custom_notification_item.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  Widget build(BuildContext context) {
    final NotificationCubit cubit = BlocProvider.of<NotificationCubit>(context);
    cubit.fetchBeersNotification(cubit.limit,type, context);
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          cubit.limit=cubit.limit+10;
          cubit.fetchBeersNotification(cubit.limit,type,
              context);// استدعاء fetchMoreBeers عندما يتم التمرير لأسفل
        }
        return false;
      },
      child: Scaffold(
          appBar: PreferredSize(
            child: CustomAppBar(title: '${getLang(context, 'notifications')}',hasBackButton: true),
            preferredSize: Size(double.infinity, 70.h),
          ),
          body: BlocConsumer<NotificationCubit, NotificationState>(
        builder: (BuildContext context, NotificationState state) {
          NotificationModel? data = type == 'user' ? cubit.notificationModelData
              : cubit.notificationModelProviderData;
          if (data != null) {
            if (data.data!.notifications!.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SvgPicture.asset(IconsManager.not)),
                  Text(
                    '${getLang(context, 'notification_no_data')}',
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: textGeryColor,
                      fontWeight: FontWeightManager.bold,
                      fontFamily: FontConstants.lateefFont,
                    ),
                  ),
                ],
              );
            }
            else {
              return RefreshIndicator(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                 if(index < data.data!.notifications!.length){
                   return CustomNotificationItem(
                     notifications: data.data!.notifications![index],
                     type: type,
                   );
                 }else{
                   if (index == data.data!.notifications!.length) {
                     if(cubit.loading==true){
                       return _buildLoader();
                     }else{
                       return Container();
                     }
                   } else {
                     return Container();
                   }
                 }
                },
                itemCount: data.data!.notifications!.length+1,
                shrinkWrap: true,
              ),
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                    NotificationCubit.get(context).getNotification(10,type, context);
                  });
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        listener: (BuildContext context, NotificationState state) {},
      )),
    );
  }

}
Widget _buildLoader() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: CircularProgressIndicator(), // استخدام CircularProgressIndicator كمؤشر تحميل
    ),
  );
}