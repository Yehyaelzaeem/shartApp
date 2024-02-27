import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shart/core/resources/assets_menager.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/shared_screens/notifications/data/models/notificationModel.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../logic/notification_cubit.dart';
import '../widgets/custom_notification_item.dart';
import 'package:smartrefresh/smartrefresh.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context) {
    NotificationCubit cubit = NotificationCubit.get(context);
    return
      RefreshIndicator(
          child: Scaffold(
            appBar: PreferredSize(
              child: CustomAppBar(title: '${getLang(context, 'notifications')}',
                  hasBackButton: true),
              preferredSize: Size(double.infinity, 70.h),
            ),
            body: BlocConsumer<NotificationCubit, NotificationState>(
              listener: (BuildContext context, NotificationState state) {},
              builder: (BuildContext context, NotificationState state) {
                NotificationModel? data = type == 'user' ? cubit
                    .notificationModelData : cubit
                    .notificationModelProviderData;

                if (data != null) {
                  if (data.data!.notifications!.length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.4,
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
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= data.data!.notifications!.length) {
                          context.read<NotificationCubit>().getNotification(type, context);
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomNotificationItem(
                          notifications: data.data!.notifications![index],
                          type: type,);
                      },
                      itemCount: data.data!.notifications!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 24.h),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            NotificationCubit.get(context).getNotification(type, context);
          });
  }
}