part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class GetCartDataState extends CartState {}
class SetItemsCartDataState extends CartState {}
class GetItemsCartDataState extends CartState {}
class AddCounterCartDataState extends CartState {}
class RemoveCounterCartDataState extends CartState {}
class AddQuantityState extends CartState {}
class DeleteQuantityState extends CartState {}
class RemoveItemsState extends CartState {}
class AddTotalPriceState extends CartState {}
class RemoveTotalPriceState extends CartState {}
class SendOrderState extends CartState {}
class ChangeStepState extends CartState {}
class ChangeLoadingState extends CartState {}
