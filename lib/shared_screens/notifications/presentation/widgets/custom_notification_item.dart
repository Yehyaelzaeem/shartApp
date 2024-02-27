import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color.dart';
import '../../data/models/notificationModel.dart';
import '../../logic/notification_cubit.dart';
import '../screens/order_details.dart';
import 'custom_avatar_grow.dart';

class CustomNotificationItem extends StatelessWidget {
  const CustomNotificationItem({super.key, required this.notifications, required this.type});
  final  Notifications notifications;
  final String type;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        if(notifications.orderId!=null){
          print('order id : ${notifications.orderId!}');
          NotificationCubit.get(context).getSingleOrder(notifications.orderId!, type, context).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>NotificationOrderDetails()));
          });
        }else{

        }

      },
      child: Container(
        margin: EdgeInsets.only(top: 16.h,right: 16.w,left: 16.w),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffDCDCDC))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomAvatarGrowWidget(glowColor: primaryColor, icon: Icons.notifications_active_outlined,),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${notifications.title}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${notifications.body}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xff818181),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
