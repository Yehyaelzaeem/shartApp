part of 'my_orders_cubit.dart';

@immutable
abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}
class GetMyOrderState extends MyOrdersState {}
class PaymentLoadingState extends MyOrdersState {}
class PaymentSuccessState extends MyOrdersState {}
class PaymentErrorState extends MyOrdersState {}
