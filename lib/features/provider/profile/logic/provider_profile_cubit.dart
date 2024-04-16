import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../../../../shared_screens/google_map/address_location_model.dart';
import '../../../../widgets/show_toast_widget.dart';
import '../data/model/about_compay_model.dart';
import '../data/model/address_list_model.dart';
import '../data/model/address_model.dart';
import '../data/model/complete_model.dart';
import '../data/model/delete_account_model.dart';
import '../data/model/user_profile_model.dart';
import '../data/model/wallet_model.dart';
import '../data/remote_data_base/provider_profile_data_base.dart';
part 'provider_profile_state.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  ProviderProfileCubit() : super(ProviderProfileInitial());
  static ProviderProfileCubit get(BuildContext context)=>BlocProvider.of(context);
  ProviderProfileRemoteDataSource providerProfileRemoteDataSource =ProviderProfileRemoteDataSource();
  ProviderGetProfileModel? providerProfileModel;
  final GlobalKey<FormState> formKeyEditProvider = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool passwordVisibility = true;
  bool passwordConfirmVisibility = true;
  TextEditingController nameControllerProvider = TextEditingController();
  TextEditingController emailControllerProvider = TextEditingController();
  TextEditingController phoneControllerProvider = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressPhoneController = TextEditingController();
  TextEditingController addressAddNameController = TextEditingController();
  TextEditingController addressAddController = TextEditingController();
  TextEditingController addressAddPhoneController = TextEditingController();
  TextEditingController titleCompleteProfileController = TextEditingController();
  TextEditingController numberCommercialCompleteProfileController = TextEditingController();
  TextEditingController addressCompleteProfileController = TextEditingController();
  TextEditingController iPanCompleteProfileController = TextEditingController();
  TextEditingController dateCompleteProfileController = TextEditingController();

  String selectValue='';
  GoogleMapController? mapController;
  double? lat;
  double? long;



  Position? p ;
  Future<void> getLocation(context)async{
    selectValue=getLang(context, 'main_address3');
    emit(TestState());

    p =await Geolocator.getCurrentPosition().then((Position value) {
      lat=value.latitude;
      long=value.longitude;
      print('lat : => $lat');
      print('long : => $long');
      emit(TestState());
    });

  }
  AddressListModel? addressList;
  int addressType = 0;

  AddressLocationModel? addressLocationModel;
  AddressLocationModel? addressLocationModelEditor;
  bool isAddressEditing =false;
  bool isUpdateLoading =false;
  bool isUpdateEditingLoading =false;
  void putDataOfLocationEditor(AddressLocationModel x){
    addressLocationModelEditor =x;
    emit(UpdateUserProfile());
  }
  Future<ProviderGetProfileModel?> getProviderProfile (String token ,BuildContext context)async{
    if(token.isNotEmpty){
      providerProfileRemoteDataSource.getProviderProfile(token, context).then((ProviderGetProfileModel? value) {
        providerProfileModel=value;
        nameControllerProvider.text=providerProfileModel!.data!.name!;
        emailControllerProvider.text=providerProfileModel!.data!.email!;
        phoneControllerProvider.text=providerProfileModel!.data!.phone!;
        emit(GetProviderProfileState(value!));

      });
    }else{
      print('token is empty getProviderProfile');
    }
    return null;
  }
  void putProfileData(){
    nameControllerProvider.text=providerProfileModel!.data!.name!;
    emailControllerProvider.text=providerProfileModel!.data!.email!;
    phoneControllerProvider.text=providerProfileModel!.data!.phone!;
    emit(UpdateUserProfile());
  }
  Future<ProviderGetProfileModel?> updateProviderProfile
      ( ProviderGetProfileModel oldUserProfile ,String token ,BuildContext context)async{
    if(token.isNotEmpty){
      if(nameControllerProvider.text.isEmpty&&emailControllerProvider.text.isEmpty&&phoneControllerProvider.text.isEmpty&&profileImageProviderFile==null){
        showToast(text: 'please enter your data to need update', state: ToastStates.warning, context: context);
      }else{
        ProviderGetProfileModel userProfileModel = ProviderGetProfileModel(
            data: ProviderGetProfileModelData(
              name: nameControllerProvider.text.isNotEmpty?nameControllerProvider.text:oldUserProfile.data!.name,
              email:emailControllerProvider.text.isNotEmpty?emailControllerProvider.text:oldUserProfile.data!.email,
              phone: phoneControllerProvider.text.isNotEmpty?phoneControllerProvider.text:oldUserProfile.data!.phone,
              image: profileImageProviderFile!=null?profileImageProviderFile!.path:null,
              phoneCountry: PhoneCountry(
                  id: 3
              ),
            )
        );
        providerProfileRemoteDataSource.updateProviderProfile(userProfileModel, token, context);
      }
    }else{
      print('token is empty');
    }

    emit(UpdateUserProfile());
    return null;
  }

  Future<DeleteAccountProviderModel?> deleteAccountProvider (String token ,BuildContext context)async{
    providerProfileRemoteDataSource.deleteAccountProvider(token, context);
    emit(DeleteAccountState());
    return null;
  }



  //Address
  Future<AddressListModel?> getAddressListProvider(String token ,BuildContext context)async{
    if(token.isNotEmpty){
      providerProfileRemoteDataSource.getAddressListProvider(token, context).then((AddressListModel? value) {
        addressList= value;

        emit(GetAddressListState());
      });
    }
    else{
      print('token is empty getProviderProfile');
    }
    return null;
  }
  Future<AddressModel?> addAddressProvider(String token ,BuildContext context)async{
    AddressModelData addressModelData= AddressModelData(
      name: addressAddNameController.text,
      address: addressAddController.text,
      phone: addressAddPhoneController.text,
      lng: long!.toString(),
      lat: lat!.toString(),
      note:addressLocationModel!=null?'${addressLocationModel!.country},${addressLocationModel!.bigCity},${addressLocationModel!.city},${addressLocationModel!.locality},${addressLocationModel!.street}':'',
    );

    if(token.isNotEmpty&&addressModelData.name!.isNotEmpty&&addressModelData.address!.isNotEmpty&&addressModelData.phone!.isNotEmpty&&addressModelData.lng!.isNotEmpty&&addressModelData.lat!.isNotEmpty){
      providerProfileRemoteDataSource.addAddressProvider(addressModelData ,token, context);
      // getAddressListProvider(token,context);
      emit(AddAddressState());
    }else{
      showToast(text: '${getLang(context, 'complete_data')}', state: ToastStates.error, context: context);
    }
    return null;
  }
  Future<AddressModel?> editAddressProvider(AddressModelData addressData,int id,String token ,BuildContext context)async{

    AddressModelData addressModelData= AddressModelData(
      id: id,
      name: addressNameController.text.isEmpty?addressData.name:addressNameController.text,
      address: addressController.text.isEmpty?addressData.address:addressController.text,
      phone: addressPhoneController.text.isEmpty?addressData.phone:addressPhoneController.text,
      lat: addressData.lat,
      lng: addressData.lng,
      note: addressLocationModelEditor!=null?
      '${addressLocationModelEditor!.country}/${addressLocationModelEditor!.bigCity}'
          '/${addressLocationModelEditor!.city}/${addressLocationModelEditor!.locality}/${addressLocationModelEditor!.street}':''
    );

    if(token.isNotEmpty){
      providerProfileRemoteDataSource.editAddressProvider(addressModelData ,token, context);
      getAddressListProvider(token,context);
    }
    else{
      print('token is empty getProviderProfile');
    }
    emit(EditAddressState());
    return null;
  }
  Future<AddressModel?> deleteAddressProvider(int id,String token ,BuildContext context)async{

    if(token.isNotEmpty){
      providerProfileRemoteDataSource.deleteAddressProvider(id ,token, context);
      getAddressListProvider(token,context);
    }
    else{
      print('token is empty getProviderProfile');
    }
    emit(DeleteAddressState());
    return null;
  }

  AboutCompanyModel? aboutCompanyModel;
  AboutCompanyModel? privacyProvider;
  AboutCompanyModel? termsAndConditionsProvider;
  //About Company
  void getAboutCompanyProvider(BuildContext context)async{
    providerProfileRemoteDataSource.getABoutCompanyProvider(context).then((AboutCompanyModel? value) {
      aboutCompanyModel =value;
      emit(AboutCompanyState());

    });
  }
  void getPrivacyProvider(BuildContext context)async{
    providerProfileRemoteDataSource.getPrivacyProvider(context).then((AboutCompanyModel? value) {
      privacyProvider =value;
      emit(AboutCompanyState());

    });
  }
  void getTermsAndConditionsProvider(BuildContext context)async{
    providerProfileRemoteDataSource.getTermsAndConditionsProvider(context).then((AboutCompanyModel? value) {
      termsAndConditionsProvider =value;
      emit(AboutCompanyState());

    });
  }

  void afterChangeLanguage(BuildContext context){
    getProviderProfile(AuthProviderCubit.get(context).token, context);
    getAboutCompanyProvider(context);
    getPrivacyProvider(context);
    getTermsAndConditionsProvider(context);
    emit(ChangeLanguageState());
  }



  void changeRadio(int? val) {
    addressType = val!;
    emit(ChangeRadio());

  }
  Future<dynamic> sendFCMToken (String token ,String FcmToken )async{
    await  providerProfileRemoteDataSource.sendFCMToken(token, FcmToken);
    emit(FCMTokenState());
  }
  void sendCompleteProfile(BuildContext context){
    if(titleCompleteProfileController.text.isNotEmpty&&numberCommercialCompleteProfileController.text.isNotEmpty
        &&iPanCompleteProfileController.text.isNotEmpty &&addressCompleteProfileController.text.isNotEmpty
        &&dateCompleteProfileController.text.isNotEmpty&&logoCompleteFile!=null&&idCompleteFile!=null&&pdfCompleteFile!=null){
      CompleteProfileModel completeProfileModel =CompleteProfileModel(
        storeName: titleCompleteProfileController.text.trim(),
        commercialRegistrationNo: numberCommercialCompleteProfileController.text.trim(),
        iPan: iPanCompleteProfileController.text.trim(),
        commercialEndDate: dateCompleteProfileController.text.trim(),
        mainAddress: addressCompleteProfileController.text.trim(),
      );
      providerProfileRemoteDataSource.sendCompleteProfile(false,AuthProviderCubit.get(context).token, completeProfileModel, context);
    }else{
      showToast(text: 'please complete required data', state: ToastStates.error, context: context);
    }
   }
   void updateCompleteProfile(BuildContext context){
    if(titleCompleteProfileController.text.isNotEmpty&&numberCommercialCompleteProfileController.text.isNotEmpty
        &&iPanCompleteProfileController.text.isNotEmpty &&addressCompleteProfileController.text.isNotEmpty
        &&dateCompleteProfileController.text.isNotEmpty){
      CompleteProfileModel completeProfileModel =CompleteProfileModel(
        storeName: titleCompleteProfileController.text.trim(),
        commercialRegistrationNo: numberCommercialCompleteProfileController.text.trim(),
        iPan: iPanCompleteProfileController.text.trim(),
        commercialEndDate: dateCompleteProfileController.text.trim(),
        mainAddress: addressCompleteProfileController.text.trim(),
      );
      providerProfileRemoteDataSource.sendCompleteProfile(true,AuthProviderCubit.get(context).token, completeProfileModel, context);
    }else{
      showToast(text: 'please complete required data', state: ToastStates.error, context: context);
    }
   }
  void displayDataOfScreen(){
    ProviderGetProfileModelData data =providerProfileModel!.data!;
    titleCompleteProfileController.text=data.storeName!;
    numberCommercialCompleteProfileController.text=data.commercialRegistrationNo!;
    iPanCompleteProfileController.text=data.ipan!;
    addressCompleteProfileController.text=data.mainAddress!;
    dateCompleteProfileController.text=data.commercialEndDate!;
  }

  File? profileImageProviderFile;
  File? logoCompleteFile;
  File? idCompleteFile;
  File? pdfCompleteFile;
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      logoCompleteFile =File(image.path);
    }
    emit(UploadImage());
  }
  Future<void> pickImage2() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      idCompleteFile =File(image.path);
    }
    emit(UploadImage());
  }

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf'],
    );
    if (result != null) {
      String path = result.files.single.path!;
      pdfCompleteFile =File(path);
    }
    emit(UploadPDF());
  }

  Future<dynamic> uploadImage()async{
    var picker =ImagePicker();
    final image =await picker.pickImage(source: ImageSource.gallery);
    if(image !=null){
      profileImageProviderFile=File(image.path);
    }
    emit(UploadImage());

  }
  Future<dynamic> changePassword(BuildContext context,)async{
    if(passwordController.text.isNotEmpty && passwordConfirmController.text.isNotEmpty &&AuthProviderCubit.get(context).token.isNotEmpty){
      providerProfileRemoteDataSource.changePassword(passwordController.text,passwordConfirmController.text,AuthProviderCubit.get(context).token, context,);
      emit(ChangePasswordState());
    }else{
      showToast(text: '${getLang(context, 'complete_data')}', state: ToastStates.error, context: context);
    }
  }

  bool isAddLoading =false;
  void changeAddLoading(bool x){
    isAddLoading =x;
    emit(EditingAddressState());
  }void changeUpdateLoading(bool x){
    isUpdateLoading =x;
    emit(EditingAddressState());
  }
  void changeUpdateEditingLoading(bool x){
    isUpdateEditingLoading =x;
    emit(EditingAddressState());
  }
  void changeAddressEditing(bool x){
    isAddressEditing =x;
    emit(EditingAddressState());
  }
  void changePasswordVisibility(bool x){
    passwordVisibility =x;
    emit(ChangePasswordVisibility());
  }
  void changePasswordConfirmVisibility(bool x){
    passwordConfirmVisibility =x;
    emit(ChangePasswordVisibility());
  }
  WalletModel? walletModel;
  //Wallet
  Future<WalletModelData?> getWallet (BuildContext context)async{
    emit(GetMyWalletLoadingState());
    providerProfileRemoteDataSource.getWallet(context).then((  value) {
      walletModel=value!;
      emit(GetMyWalletSuccessState());
    });
    return null;
  }

}
