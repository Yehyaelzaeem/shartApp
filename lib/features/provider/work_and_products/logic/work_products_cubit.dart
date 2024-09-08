import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/provider/work_and_products/data/model/size_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/routing/navigation_services.dart';
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


  File? _videoFile;
  VideoPlayerController? controllerVideo;
  List<VideoPlayerController> controllerList=<VideoPlayerController>[];
  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      _videoFile = File(result.files.single.path!);
      controllerVideo = VideoPlayerController.file(_videoFile!);
      controllerList.add(controllerVideo!);
      controllerVideo!.initialize().then((_) {
        controllerVideo!.play();});}
    else {
      // User canceled the picker
    }
    emit(GetVideo());
  }

  ProviderProductsAndWorksRemoteDataSource productsAndWorksRemoteDataSource = ProviderProductsAndWorksRemoteDataSource();
  String typeSelectedValue = '';
  TextEditingController productNameSelectedValue = TextEditingController();
  String brandSelectedValue = '';
  String brandSelectedId = '';
  String brandModelSelectedValue = '';
  String brandModelSelectedId = '';
  String stateSelectedValue = '';
  String widthSelectedValue = '';
  String widthSelectedId = '';
  String heightSelectedValue = '';
  String heightSelectedId = '';
  String sizeSelectedValue = '';
  String sizeSelectedId = '';
  String namePriceProduct = '';
  String nameImageProduct = '';
  void addNamed(String name){
    namePriceProduct=name;
    emit(GetImageState());

  } void addNamedImage(String name){
    nameImageProduct=name;
    emit(GetImageState());

  }
  void reSt(){

  }
  void reStarting( GetProductsModelData getProductsModelData){
    typeSelectedValue='${getLang(NavigationManager.navigationKey.currentContext!, '${getProductsModelData.type}')}';

    if(getProductsModelData.type=='spare_parts'){
      changeTypeAdd(false);
      // controllerCubit.typeSelectedValue=widget.getProductsModelData.type!;
      productNameSelectedValue.text=getProductsModelData.title!;
      brandSelectedId=getProductsModelData.brand!.id!.toString();
      brandSelectedValue=getProductsModelData.brand!.name!;
     brandModelSelectedId=getProductsModelData.modalId!.toString();
     stateSelectedValue=getProductsModelData.productStatus!;
      priceController.text=getProductsModelData.price!.toString();
      desController.text=getProductsModelData.description!.toString();
      brandModelSelectedValue=getProductsModelData.modal!.name.toString();

    }else{
      changeTypeAdd(true);
      productNameSelectedValue.text=getProductsModelData.title!;
      stateSelectedValue=getProductsModelData.productStatus!;
      brandSelectedId=getProductsModelData.brand!.id!.toString();
      brandSelectedValue=getProductsModelData.brand!.name!;
      brandModelSelectedId=getProductsModelData.modalId!.toString();
      brandModelSelectedValue=getProductsModelData.modal!.name.toString();
      widthSelectedValue=getProductsModelData.width!=null?getProductsModelData.width!.name.toString():'';
      heightSelectedValue=getProductsModelData.height!=null?getProductsModelData.height!.name.toString():'';
      sizeSelectedValue=getProductsModelData.size!=null?getProductsModelData.size!.name.toString():'';
      priceController.text=getProductsModelData.price!.toString();
      desController.text=getProductsModelData.description!.toString();
    }
        emit(GetImageState());
  }
  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isParts = false;
  XFile? image;
  Iterable<ImageFile>? images = <ImageFile>[];
  Iterable images2 = <ImageFile>[];
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
  SizeModel? listSize;
  SizeModel? listHeight;
  SizeModel? listWidth;
  void getSize(BuildContext context){
    productsAndWorksRemoteDataSource.getSharedSize(context).then((SizeModel? value) {
      listSize=value!;
      emit(GetSizeState());
    });
  }
  void getHeight(BuildContext context){
    productsAndWorksRemoteDataSource.getSharedHeight(context).then((SizeModel? value) {
      listHeight=value!;
      emit(GetSizeState());
    });
  }
  void getWidth(BuildContext context){
    productsAndWorksRemoteDataSource.getSharedWidth(context).then((SizeModel? value) {
      listWidth=value!;
      emit(GetSizeState());
    });
  }
  bool isSearchStart=false;

  void changeSearchStart(bool x){
    isSearchStart=x;
    emit(ChangeTypeState());
  }
  void changeAddingState(bool a) {
    isAdding = a;
    emit(ChangeTypeState());
  }

  void addProduct(BuildContext context) {
    changeUpdateLoading(true);
    images = multiImagePickerController.images;
    imagesFile.clear();
    if (images != null) {
      for (ImageFile asset in images!) {
        String? path = asset.path;
        final File file = File('$path');
        imagesFile.add(file);
      }
    }
    //
    // if (controllerList.isNotEmpty) {
    //   for (VideoPlayerController asset in controllerList) {
    //     String videoFilePath = asset.dataSource.substring(7);
    //     if (videoFilePath.isNotEmpty) {
    //       File file2 = File(videoFilePath);
    //       // final File file = File('$videoFilePath');
    //       if (file2.existsSync()) {
    //         // Now you have the 'file' object, you can use it as needed
    //         // For example, you can upload it to an API or perform other operations
    //         print(' exist');
    //         imagesFile.add(file2);
    //       } else {
    //         print('Error: File does not exist');
    //       }
    //       // Now you have the 'file' object, you can use it as needed
    //       // For example, you can upload it to an API or perform other operations
    //     } else {
    //       print('Error: File not found or invalid path');
    //     }
    //
    //   }
    // }
    // print('dfsdsfds => ${imagesFile.toList()}');

    String type;
    if (typeSelectedValue == 'قطع غيار' || typeSelectedValue == 'spare parts') {
      type = 'spare_parts';
    } else if (typeSelectedValue == 'إطارات'||typeSelectedValue == 'tires') {
      type = 'tires';
    } else {
      type = 'rims';
    }
    ProductPushDataModel productPushDataModel = ProductPushDataModel(
      title: productNameSelectedValue.text,
      type: type,
      brandId: brandSelectedId,
      modelId: brandModelSelectedId,
      state: stateSelectedValue == '${getLang(context, 'new')}' ? 'new' : 'used',
      description: desController.text,
      price: priceController.text,
      width: widthSelectedValue == '${getLang(context, 'width')}' ? '' : widthSelectedId,
      height: heightSelectedValue == '${getLang(context, 'height')}' ? '' : heightSelectedId,
      size: sizeSelectedValue == '${getLang(context, 'size')}' ? '' : sizeSelectedId,
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
        showToast(text: 'check your complete data',
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
        showToast(text: 'check your complete data',
            state: ToastStates.error,
            context: context);
      }
      emit(AddProductState());
    }

  }
  GetProductsModel? getProductsModel;
  void getAllProducts(BuildContext context) {
    productsAndWorksRemoteDataSource.getAllProducts(token: AuthProviderCubit.get(context).token, context: context).then((GetProductsModel? value) {
      getProductsModel=value!;
      emit(GetProductState());
    });
  }
  GetProductsModel? getProductsSearchModel;
  void getSearchProducts(String title,BuildContext context) {
    getProductsSearchModel=null;
    productsAndWorksRemoteDataSource.getAllProducts(title:title,token:AuthProviderCubit.get(context).token, context: context).then((GetProductsModel? value) {
      getProductsSearchModel=value!;
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
      for (ImageFile asset in images!) {
        String? path = asset.path;
        final File file = File('$path');
        imagesFile.add(file);
      }
    }
    String type;
    if (typeSelectedValue == 'قطع غيار') {
      type = 'spare_parts';
    }
    else if (typeSelectedValue == 'spare parts') {
      type = 'spare_parts';
    }
    else if (typeSelectedValue == 'إطارات') {
      type = 'tires';
    } else if (typeSelectedValue == 'tires') {
      type = 'tires';
    }else if (typeSelectedValue == 'حافات') {
      type = 'rims';
    } else if(typeSelectedValue == 'rims') {
      type = 'rims';
    }     else{
                   type = 'spare_parts';
    }
    ProductPushDataModel productPushDataModel = ProductPushDataModel(
      title: productNameSelectedValue.text,
      type: type,
      brandId: brandSelectedId,
      modelId: brandModelSelectedId,
      state: stateSelectedValue == 'جديد' ? 'new' :stateSelectedValue == 'new'?'new': 'used',
      description: desController.text,
      price: priceController.text,
      width: widthSelectedValue == 'العرض' ? '' : widthSelectedId,
      height: heightSelectedValue == 'الارتفاع' ? '' : heightSelectedId,
      size: sizeSelectedValue == 'حجم الجنط' ? '' : sizeSelectedId,
    );
    if (productNameSelectedValue.text.isNotEmpty && type.isNotEmpty &&
        brandSelectedId.isNotEmpty && brandModelSelectedId.isNotEmpty &&
        stateSelectedValue.isNotEmpty && desController.text.isNotEmpty &&
        priceController.text.isNotEmpty
    ) {
      productsAndWorksRemoteDataSource.editProduct(AuthProviderCubit.get(context).token, productPushDataModel, id, context);
    } else {
      showToast(text: 'check your complete data',
          state: ToastStates.error,
          context: context);
    }
    emit(EditProductState());
  }
  String desControllerHitText='';
  String priceControllerHitText='';
  String nameControllerHitText='';
  void displayTitle(BuildContext context){
    typeSelectedValue = '${getLang(context, 'type')}';
    brandSelectedValue = '${getLang(context, 'brand')}';
    brandModelSelectedValue = '${getLang(context, 'car_model')}';
    stateSelectedValue = '${getLang(context, 'status')}';
    widthSelectedValue = '${getLang(context, 'width')}';
    heightSelectedValue = '${getLang(context, 'height')}';
    sizeSelectedValue = '${getLang(context, 'size')}';
    priceController.text='';
    productNameSelectedValue.text='';
    desController.text='';
    priceController.text='';
    desControllerHitText='${getLang(context, 'des')}';
    nameControllerHitText='${getLang(context, 'product_name')}';
    priceControllerHitText='${getLang(context, 'unit_price')}';
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
    productsAndWorksRemoteDataSource.getWorks(AuthProviderCubit.get(context).token, context).then((WorksModel? value) {
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
