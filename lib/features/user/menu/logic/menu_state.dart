part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}
class GetPackageCheckState extends MenuState {
  final PackageCheckModel packageCheckModel;
  GetPackageCheckState(this.packageCheckModel);
}
class GetBannersState extends MenuState {
  final BannersModel bannersModel;
  GetBannersState(this.bannersModel);
}
class RemoveState extends MenuState {}
class ChangeLoadingState extends MenuState {}
class GetBannersState2 extends MenuState {}
class GetProductsState extends MenuState {}
class GetPaymentVisibilityState extends MenuState {}
