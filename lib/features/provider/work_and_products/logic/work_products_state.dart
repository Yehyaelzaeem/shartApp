part of 'work_products_cubit.dart';

@immutable
abstract class WorkProductsState {}

class WorkProductsInitial extends WorkProductsState {}
class GetImageState extends WorkProductsState {}
class GetVideo extends WorkProductsState {}
class GetProductState extends WorkProductsState {
  // final GetProductsModel getProductsModel;
  // GetProductState(this.getProductsModel) {
  // }
}
class AddProductState extends WorkProductsState {}
class DeleteProductState extends WorkProductsState {}
class EditProductState extends WorkProductsState {}
class ChangeTypeState extends WorkProductsState {}
class AddWorksState extends WorkProductsState {}
class DeleteWorksState extends WorkProductsState {}
class IsLoadingState extends WorkProductsState {}
class GetSizeState extends WorkProductsState {}
class GetWorksState extends WorkProductsState {
  // final WorksModel worksModel;
  // GetWorksState(this.worksModel);
}
