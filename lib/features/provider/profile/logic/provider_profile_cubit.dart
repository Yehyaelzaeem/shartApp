import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/show_toast_widget.dart';
import '../data/model/about_compay_model.dart';
import '../data/model/address_list_model.dart';
import '../data/model/address_model.dart';
import '../data/model/delete_account_model.dart';
import '../data/model/user_profile_model.dart';
import '../data/remote_data_base/provider_profile_data_base.dart';
part 'provider_profile_state.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  ProviderProfileCubit() : super(ProviderProfileInitial());
  static ProviderProfileCubit get(BuildContext context)=>BlocProvider.of(context);
  ProviderProfileRemoteDataSource providerProfileRemoteDataSource =ProviderProfileRemoteDataSource();
  List<ProviderGetProfileModel> userProfileModelList=<ProviderGetProfileModel>[];
  ProviderGetProfileModel? providerProfileModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressPhoneController = TextEditingController();
  TextEditingController addressAddNameController = TextEditingController();
  TextEditingController addressAddController = TextEditingController();
  TextEditingController addressAddPhoneController = TextEditingController();
  AddressListModel? addressList;
  int addressType = 0;


  bool isAddressEditing =false;
  bool isUpdateLoading =false;

  Future<ProviderGetProfileModel?> getProviderProfile (String token ,BuildContext context)async{
    if(token.isNotEmpty){
      providerProfileRemoteDataSource.getProviderProfile(token, context).then((ProviderGetProfileModel? value) {
        providerProfileModel=value;
        userProfileModelList.add(value!);
        print('name : ${providerProfileModel!.data!.name}');
        print('email : ${providerProfileModel!.data!.email}');
        print('phone : ${providerProfileModel!.data!.phone}');
      });
    }else{
      print('token is empty getProviderProfile');
    }
    emit(GetUserProfileState());
    return null;
  }
  Future<ProviderGetProfileModel?> updateProviderProfile
      ( ProviderGetProfileModel oldUserProfile ,String token ,BuildContext context)async{
    if(token.isNotEmpty){
      if(nameController.text.isEmpty&&emailController.text.isEmpty&&phoneController.text.isEmpty&&profileImageProviderFile==null){
        showToast(text: 'please enter your data to need update', state: ToastStates.warning, context: context);
      }else{
        ProviderGetProfileModel userProfileModel = ProviderGetProfileModel(
            data: ProviderGetProfileModelData(
              name: nameController.text.isNotEmpty?nameController.text:oldUserProfile.data!.name,
              email:emailController.text.isNotEmpty?emailController.text:oldUserProfile.data!.email,
              phone: phoneController.text.isNotEmpty?phoneController.text:oldUserProfile.data!.phone,
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
      });
    }
    else{
      print('token is empty getProviderProfile');
    }
    emit(GetAddressListState());
    return null;
  }
  Future<AddressModel?> addAddressProvider(String token ,BuildContext context)async{
    AddressModelData addressModelData= AddressModelData(
      name: addressAddNameController.text,
      address: addressAddController.text,
      phone: addressAddPhoneController.text,
      lng: '123',
      lat: '123456',
    );

    if(token.isNotEmpty&&addressAddNameController.text.isNotEmpty&&addressAddController.text.isNotEmpty&&addressAddPhoneController.text.isNotEmpty){
      providerProfileRemoteDataSource.addAddressProvider(addressModelData ,token, context);
      getAddressListProvider(token,context);
    }
    else{
      print('token  or any data required is empty getProviderProfile');
    }
    emit(AddAddressState());
    return null;
  }
  Future<AddressModel?> editAddressProvider(AddressModelData addressData,int id,String token ,BuildContext context)async{

    AddressModelData addressModelData= AddressModelData(
      id: id,
      name: addressNameController.text.isEmpty?addressData.name:addressNameController.text,
      address: addressController.text.isEmpty?addressData.address:addressController.text,
      phone: addressPhoneController.text.isEmpty?addressData.phone:addressPhoneController.text,
      lat: '123456',
      lng: '123',
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
    });
    emit(AboutCompanyState());
  }
  void getPrivacyProvider(BuildContext context)async{
    providerProfileRemoteDataSource.getPrivacyProvider(context).then((AboutCompanyModel? value) {
      privacyProvider =value;
    });
    emit(AboutCompanyState());
  }
  void getTermsAndConditionsProvider(BuildContext context)async{
    providerProfileRemoteDataSource.getTermsAndConditionsProvider(context).then((AboutCompanyModel? value) {
      termsAndConditionsProvider =value;
    });
    emit(AboutCompanyState());
  }

  void afterChangeLanguage(BuildContext context){
    getAboutCompanyProvider(context);
    getPrivacyProvider(context);
    getTermsAndConditionsProvider(context);
    emit(ChangeLanguageState());
  }



  void changeRadio(int? val) {
    addressType = val!;
    emit(ChangeRadio());

  }




  File? profileImageProviderFile;

  Future<dynamic> uploadImage()async{
    var picker =ImagePicker();
    final image =await picker.pickImage(source: ImageSource.gallery);
    if(image !=null){
      profileImageProviderFile=File(image.path);
    }
    emit(UploadImage());

  }
  void changeUpdateLoading(bool x){
    isUpdateLoading =x;
    emit(GetUserProfileState());
  }
  void changeAddressEditing(bool x){
    isAddressEditing =x;
    emit(EditingAddressState());
  }
}
