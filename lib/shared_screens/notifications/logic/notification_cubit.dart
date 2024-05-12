import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/shared_screens/notifications/data/models/single_order_model.dart';
import '../data/data_base/date_base.dart';
import '../data/models/notificationModel.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(BuildContext context)=>BlocProvider.of(context);
  RemoteNotificationDataSource remoteNotificationDataSource =RemoteNotificationDataSource();
  NotificationModel? notificationModelData;
  NotificationModel? notificationModelProviderData;
  SingleOrderModel? singleOrderModelData;
  bool loading = false;

 void changeState(){
   emit(GetNotificationTestState());
 }


  int limit =10;
  void _showNotification() {
    loading=false;
    emit(GetNotificationTestState());
    print('All beers loaded!');
  }
  void fetchBeersNotification(int limit ,String type ,BuildContext context) async {
    try {
      final List<Notifications> beers = await getNotification(limit,type,context);
      loading==true;
      changeState();
      emit(GetNotificationState(beers));
      _showNotification();
    } catch (_) {
      // Handle error
    }
  }
 Future<List<Notifications>> getNotification(int limit ,String type ,BuildContext context)async{
   emit(GetNotificationTestState());
   await remoteNotificationDataSource.getNotification(limit,type,
       type=='user'?AuthCubit.get(context).token:AuthProviderCubit.get(context).token, context).then((NotificationModel? value) {
         type=='user'?
         notificationModelData=value!:
         notificationModelProviderData=value!;
   });
  return type=='user'?
   notificationModelData!.data!.notifications!:
   notificationModelProviderData!.data!.notifications!;
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
