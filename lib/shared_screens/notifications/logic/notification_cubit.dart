import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/shared_screens/notifications/data/models/single_order_model.dart';

import '../../../core/resources/color.dart';
import '../data/data_base/date_base.dart';
import '../data/models/notificationModel.dart';
part 'notification_state.dart';
enum NotificationStatus {initial, success, failure }

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(BuildContext context)=>BlocProvider.of(context);
  RemoteNotificationDataSource remoteNotificationDataSource =RemoteNotificationDataSource();
  NotificationModel? notificationModelData;
  NotificationModel? notificationModelProviderData;
  SingleOrderModel? singleOrderModelData;
  int page = 1;
  bool hasMore = true;
  bool loading = false;



  NotificationStatus status = NotificationStatus.initial;
 void changeState(){
   emit(GetNotificationState());
 }

 Future<dynamic> getNotification(String type ,BuildContext context)async{
   notificationModelData=null;
   notificationModelProviderData=null;
   emit(GetNotificationState());
   await remoteNotificationDataSource.getNotification(type,
       type=='user'?AuthCubit.get(context).token:AuthProviderCubit.get(context).token, context).then((NotificationModel? value) {
         type=='user'?
         notificationModelData=value!:
         notificationModelProviderData=value!;
     emit(GetNotificationState());
   });
 }

 Future<dynamic> getSingleOrder(int id,String type ,BuildContext context)async{
   await remoteNotificationDataSource.getSingleOrder(type,id,
       type=='user'?AuthCubit.get(context).token:AuthProviderCubit.get(context).token, context).then(( SingleOrderModel? value) {
         type=='user'?
         singleOrderModelData=value!:
         singleOrderModelData=value!;
     emit(GetSingleOrderState());
   });
 }

}
