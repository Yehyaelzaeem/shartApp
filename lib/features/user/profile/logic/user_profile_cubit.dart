import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/features/user/profile/data/model/message_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../../core/localization/appLocale.dart';
import '../../../../shared_screens/google_map/address_location_model.dart';
import '../../../provider/profile/data/model/about_compay_model.dart';
import '../../../provider/profile/data/model/address_list_model.dart';
import '../../../provider/profile/logic/provider_profile_cubit.dart';
import '../data/model/delete_account_model.dart';
import '../data/model/user_profile_model.dart';
import '../data/remote_data_base/user_profile_data_base.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  static UserProfileCubit get(BuildContext context)=>BlocProvider.of(context);
  UserProfileRemoteDataSource userProfileRemoteDataSource =UserProfileRemoteDataSource();
   // List<UserProfileModel> userProfileModelList=<UserProfileModel>[];
  UserProfileModel? userProfileModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressPhoneController = TextEditingController();
  TextEditingController addressAddNameController = TextEditingController();
  TextEditingController addressAddController = TextEditingController();
  TextEditingController addressAddPhoneController = TextEditingController();
  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool passwordVisibility = true;
  bool passwordConfirmVisibility = true;

  TextEditingController complainController = TextEditingController();
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
  bool isGetLoading =false;
  bool isUpdateLoading =false;
  //User Profile
  Future<UserProfileModel?> getUserProfile (String token ,BuildContext context)async{
    userProfileModel=null;
    userProfileRemoteDataSource.getUserProfile(token, context).then((UserProfileModel? value) {
      userProfileModel=value;
      nameController.text=userProfileModel!.data!.name.toString();
      emailController.text=userProfileModel!.data!.email.toString();
      phoneController.text=userProfileModel!.data!.phone.toString();
      // userProfileModelList.add(value!);
      emit(GetUserProfileState(value!));
    });
    // emit(GetUserProfileState());
    return null;
  }

  Future<UserProfileModel?> updateUserProfile ( UserProfileModel oldUserProfile ,String token ,BuildContext context)async{
    UserProfileModel userProfileModel =UserProfileModel(
        data: Data(
          name: nameController.text.isNotEmpty?nameController.text:oldUserProfile.data!.name,
          email:emailController.text.isNotEmpty?emailController.text:oldUserProfile.data!.email,
          phone: phoneController.text.isNotEmpty?phoneController.text:oldUserProfile.data!.phone,
          image: profileImageFile!=null? profileImageFile!.path:null,
          phoneCountry: PhoneCountry(
              id: 3
          ),
        )

    );
    userProfileRemoteDataSource.updateProfile(userProfileModel, token, context);
    emit(UpdateUserProfile());
    return null;
  }

  Future<DeleteAccountModel?> deleteAccount (String token ,BuildContext context)async{
    userProfileRemoteDataSource.deleteAccount(token, context);
    emit(DeleteAccountState());
    return null;
  }






//Company
  AboutCompanyModel? aboutCompanyModel;
  AboutCompanyModel? privacyUser;
  AboutCompanyModel? termsAndConditionsUser;
  //About Company
  void getAboutCompanyUser(BuildContext context)async{
    userProfileRemoteDataSource.getABoutCompanyUser(context).then((AboutCompanyModel? value) {
      aboutCompanyModel =value;
    });
    emit(AboutCompanyUserState());
  }
  void getPrivacyUser(BuildContext context)async{
    userProfileRemoteDataSource.getPrivacyUser(context).then((AboutCompanyModel? value) {
      privacyUser =value;
      emit(AboutCompanyUserState());

    });
  }
  void getTermsAndConditionsUser(BuildContext context)async{
    userProfileRemoteDataSource.getTermsAndConditionsUser(context).then((AboutCompanyModel? value) {
      termsAndConditionsUser =value;
      emit(AboutCompanyUserState());

    });
  }
  void sendComplaintMessage(String type ,BuildContext context)async{
    ProviderProfileCubit c =ProviderProfileCubit.get(context);
   if(complainController.text.isNotEmpty){
     MessageModel messageModel =MessageModel(
         name: userProfileModel!=null?userProfileModel!.data!.name!:c.providerProfileModel!.data!.name,
         phone:userProfileModel!=null?userProfileModel!.data!.phone:c.providerProfileModel!.data!.phone,
         email:userProfileModel!=null?userProfileModel!.data!.email:c.providerProfileModel!.data!.email,
         message:complainController.text,
         type: type,
         message_type:'complaint'
     );
     userProfileRemoteDataSource.sendComplaintMessage(messageModel,context);
     emit(AboutCompanyUserState());
   }
   else{
     print('message empty');

   }
  }
  //Address
  Future<AddressListModel?> getAddressListUser(String token ,BuildContext context)async{
    if(token.isNotEmpty){
      userProfileRemoteDataSource.getAddressListUser(token, context).then((AddressListModel? value) {
        addressList= value;
        emit(GetAddressListUserState());
      });
    }
    else{
      print('token is empty getProviderProfile');
    }
    return null;
  }
  Future<dynamic> addAddressUser(String token ,BuildContext context)async{
    AddressModelData addressModelData= AddressModelData(
      name: addressAddNameController.text,
      address: addressAddController.text,
      phone: addressAddPhoneController.text,
      lng: long!.toString(),
      lat: lat!.toString(),
    );

    if(token.isNotEmpty&&addressModelData.name!=null&&addressModelData.address!=null&&addressModelData.phone!=null&&addressModelData.lng!=null&&addressModelData.lat!=null){
      userProfileRemoteDataSource.addAddressUser(addressModelData ,token, context);
      // getAddressListProvider(token,context);
      emit(AddAddressUserState());
    }
    return null;
  }
  Future<dynamic> editAddressUser(AddressModelData addressData,int id,String token ,BuildContext context)async{

    AddressModelData addressModelData= AddressModelData(
      id: id,
      name: addressNameController.text.isEmpty?addressData.name:addressNameController.text,
      address: addressController.text.isEmpty?addressData.address:addressController.text,
      phone: addressPhoneController.text.isEmpty?addressData.phone:addressPhoneController.text,
      lat: '123456',
      lng: '123',
    );

    if(token.isNotEmpty){
      userProfileRemoteDataSource.editAddressUser(addressModelData ,token, context);
      // getAddressListProvider(token,context);
    }
    else{
      print('token is empty getProviderProfile');
    }
    emit(EditAddressUserState());
    return null;
  }
  void changeRadio(int? val) {
    addressType = val!;
    emit(ChangeRadio());

  }
  Future<dynamic> deleteAddressUser(int id,String token ,BuildContext context)async{

    if(token.isNotEmpty){
      userProfileRemoteDataSource.deleteAddressUser(id ,token, context);
      // getAddressListProvider(token,context);
    }
    else{
      print('token is empty getProviderProfile');
    }
    emit(DeleteAddressUserState());
  } 
  Future<dynamic> changePassword(BuildContext context,)async{
    if(passwordController.text.isNotEmpty && passwordConfirmController.text.isNotEmpty &&AuthCubit.get(context).token.isNotEmpty){
      userProfileRemoteDataSource.changePassword(passwordController.text,passwordConfirmController.text,AuthCubit.get(context).token, context,);
      emit(ChangePasswordState());
    }else{
      showToast(text: '${getLang(context, 'complete_data')}', state: ToastStates.error, context: context);
    }
  }




//Image
  File? profileImageFile;

    Future<dynamic> uploadImage()async{
     ImagePicker picker =ImagePicker();
     final XFile? image =await picker.pickImage(source: ImageSource.gallery);
     if(image !=null){
       profileImageFile=File(image.path);
       print('path // ${profileImageFile}');
     }
     emit(UploadImage());

    }
   void changeUpdateLoading(bool x){
     isUpdateLoading =x;
     emit(LoadingState());
   }
 bool isAddLoading =false;
 bool isAddressEditing =false;
  void changeAddLoading(bool x){
    isAddLoading =x;
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
}
