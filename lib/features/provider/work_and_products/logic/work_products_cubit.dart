import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../widgets/multi_image/multi_image_picker_view.dart';
import '../data/data_base/data_base.dart';
import '../data/model/get_products_list_model.dart';
import '../data/model/product_push_data_model.dart';
import '../data/model/works_model.dart';

part 'work_products_state.dart';

class WorkProductsCubit extends Cubit<WorkProductsState> {
  WorkProductsCubit() : super(WorkProductsInitial());

  static WorkProductsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final TextEditingController searchController = TextEditingController();

  bool x = false;
  final MultiImagePickerController multiImagePickerController = MultiImagePickerController(
      maxImages: 300,
      picker: (bool allowMultiple) async {
        return await pickImagesUsingImagePicker(allowMultiple);
      });
  final MultiImagePickerController multiImagePickerControllerWorks = MultiImagePickerController(
      maxImages: 300,
      picker: (bool allowMultiple) async {
        return await pickImagesUsingImagePicker(allowMultiple);
      });

  ProviderProductsAndWorksRemoteDataSource productsAndWorksRemoteDataSource = ProviderProductsAndWorksRemoteDataSource();
  String typeSelectedValue = '';
  String productNameSelectedValue = '';
  String brandSelectedValue = '';
  String brandSelectedId = '';
  String brandModelSelectedValue = '';
  String brandModelSelectedId = '';
  String stateSelectedValue = '';
  String widthSelectedValue = '';
  String heightSelectedValue = '';
  String sizeSelectedValue = '';

  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isParts = false;
  XFile? image;
  Iterable<ImageFile>? images = <ImageFile>[];
  Iterable<ImageFile>? imagesWorks = <ImageFile>[];

  void getImage() async {
    final ImagePicker picker = ImagePicker();
    image =
    await picker.pickImage(source: ImageSource.gallery);
    emit(GetImageState());
  }

  List<File> imagesFile = <File>[];
  List<File> imagesFileWorks = <File>[];

  void changeTypeAdd(bool a) {
    isParts = a;
    emit(ChangeTypeState());
  }

  void changeType2Add(bool a) {
    x = a;
    emit(ChangeTypeState());
  }

  void changeAddingState(bool a) {
    isAdding = a;
    emit(ChangeTypeState());
  }

  void addProduct(BuildContext context) {
    images = multiImagePickerController.images;
    imagesFile.clear();
    if (images != null) {
      for (var asset in images!) {
        var path = asset.path;
        final file = File('$path');
        imagesFile.add(file);
      }
    }
    var type;
    if (typeSelectedValue == 'قطع غيار' || typeSelectedValue == 'spare parts') {
      type = 'spare_parts';
    } else if (typeSelectedValue == 'إطارات'||typeSelectedValue == 'tires') {
      type = 'tires';
    } else {
      type = 'rims';
    }
    ProductPushDataModel productPushDataModel = ProductPushDataModel(
      title: productNameSelectedValue,
      type: type,
      brandId: brandSelectedId,
      modelId: brandModelSelectedId,
      state: stateSelectedValue == '${getLang(context, 'new')}' ? 'new' : 'used',
      description: desController.text,
      price: priceController.text,
      width: widthSelectedValue == '${getLang(context, 'width')}' ? '' : widthSelectedValue,
      height: heightSelectedValue == '${getLang(context, 'height')}' ? '' : heightSelectedValue,
      size: sizeSelectedValue == '${getLang(context, 'size')}' ? '' : sizeSelectedValue,
    );
    if(type == 'spare_parts'){

      if (productPushDataModel.title!.isNotEmpty &&
          productPushDataModel.type!.isNotEmpty &&
          productPushDataModel.brandId!.isNotEmpty &&
          productPushDataModel.modelId!.isNotEmpty &&
          productPushDataModel.state!.isNotEmpty &&
          productPushDataModel.description!.isNotEmpty &&
          productPushDataModel.price!.isNotEmpty) {
        productsAndWorksRemoteDataSource.addProduct(AuthProviderCubit
            .get(context)
            .token, productPushDataModel, context);
      } else {
        showToast(text: 'check your complete dataasa',
            state: ToastStates.error,
            context: context);
      }
      emit(AddProductState());
    }else{

      if (productPushDataModel.title!.isNotEmpty &&
          productPushDataModel.type!.isNotEmpty &&
          productPushDataModel.brandId!.isNotEmpty &&
          productPushDataModel.modelId!.isNotEmpty &&
          productPushDataModel.state!.isNotEmpty &&
          productPushDataModel.description!.isNotEmpty &&
          productPushDataModel.width!.isNotEmpty &&
          productPushDataModel.height!.isNotEmpty &&
          productPushDataModel.size!.isNotEmpty &&
          productPushDataModel.price!.isNotEmpty) {
        productsAndWorksRemoteDataSource.addProduct(AuthProviderCubit
            .get(context)
            .token, productPushDataModel, context);
      } else {
        showToast(text: 'check your complete data555',
            state: ToastStates.error,
            context: context);
      }
      emit(AddProductState());
    }

  }
  GetProductsModel? getProductsModel;
  void getAllProducts(BuildContext context) {
    print('start cuibt');
    productsAndWorksRemoteDataSource.getAllProducts(AuthProviderCubit
        .get(context)
        .token, context).then((value) {
      getProductsModel=value!;
      emit(GetProductState());
    });
  }

  void deleteProduct(String id, BuildContext context) {
    productsAndWorksRemoteDataSource.delete(AuthProviderCubit
        .get(context)
        .token, id, context);
    // emit(DeleteProductState());
  }

  void editProduct(String id, BuildContext context) {
    images = multiImagePickerController.images;
    imagesFile.clear();
    if (images != null) {
      for (var asset in images!) {
        var path = asset.path;
        final file = File('$path');
        imagesFile.add(file);
      }
    }
    var type;
    if (typeSelectedValue == 'قطع غيار' || typeSelectedValue == 'spare parts') {
      type = 'spare_parts';
    } else if (typeSelectedValue == 'إطارات'||typeSelectedValue == 'tires') {
      type = 'tires';
    } else {
      type = 'rims';
    }
    ProductPushDataModel productPushDataModel = ProductPushDataModel(
      title: productNameSelectedValue,
      type: type,
      brandId: brandSelectedId,
      modelId: brandModelSelectedId,
      state: stateSelectedValue == 'جديد' ? 'new' : 'used',
      description: desController.text,
      price: priceController.text,
      width: widthSelectedValue == 'العرض' ? '' : widthSelectedValue,
      height: heightSelectedValue == 'الارتفاع' ? '' : heightSelectedValue,
      size: sizeSelectedValue == 'حجم الجنط' ? '' : sizeSelectedValue,
    );
    if (productNameSelectedValue.isNotEmpty && type != null &&
        brandSelectedId.isNotEmpty && brandModelSelectedId.isNotEmpty &&
        stateSelectedValue.isNotEmpty && desController.text.isNotEmpty &&
        priceController.text.isNotEmpty
    ) {
      productsAndWorksRemoteDataSource.editProduct(AuthProviderCubit
          .get(context)
          .token, productPushDataModel, id, context);
    } else {
      showToast(text: 'check your complete data',
          state: ToastStates.error,
          context: context);
    }
    emit(EditProductState());
  }
  void displayTitle(BuildContext context){
    typeSelectedValue = '${getLang(context, 'type')}';
    productNameSelectedValue = '${getLang(context, 'product_name')}';
    brandSelectedValue = '${getLang(context, 'brand')}';
    brandModelSelectedValue = '${getLang(context, 'model')}';
    stateSelectedValue = '${getLang(context, 'status')}';
    widthSelectedValue = '${getLang(context, 'width')}';
    heightSelectedValue = '${getLang(context, 'height')}';
    sizeSelectedValue = ' ${getLang(context, 'size')}';
  }
  bool isAdding = false;

  void addWorks(BuildContext context) {
    if(image !=null){
      productsAndWorksRemoteDataSource.addWorks(AuthProviderCubit
          .get(context)
          .token, context);
      emit(AddWorksState());
    }
    else{
      showToast(text: '${getLang(context, 'my_business_showToast1')}', state: ToastStates.error, context: context);
    }

  }

  WorksModel? worksModel;
  void getWorks(BuildContext context) {
    productsAndWorksRemoteDataSource.getWorks(AuthProviderCubit.get(context).token, context).then((value) {
      worksModel=value!;
      emit(GetWorksState());
    });

  }
  void deleteWorks(String id,BuildContext context) {
    productsAndWorksRemoteDataSource.deleteWork(AuthProviderCubit.get(context).token, id, context);
    emit(DeleteWorksState());

  }
  bool isLoading =false;
  void changeUpdateLoading(bool x){
    isLoading =x;
    emit(IsLoadingState());
  }
  bool isLoadingDelete =false;
  void changeUpdateLoadingDelete(bool x){
    isLoadingDelete =x;
    emit(IsLoadingState());
  }

}
