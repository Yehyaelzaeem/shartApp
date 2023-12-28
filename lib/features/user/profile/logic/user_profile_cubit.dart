import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shart/widgets/show_toast_widget.dart';

import '../../../provider/profile/data/model/about_compay_model.dart';
import '../data/model/delete_account_model.dart';
import '../data/model/user_profile_model.dart';
import '../data/remote_data_base/user_profile_data_base.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  static UserProfileCubit get(BuildContext context)=>BlocProvider.of(context);
  UserProfileRemoteDataSource userProfileRemoteDataSource =UserProfileRemoteDataSource();
   List<UserProfileModel> userProfileModelList=<UserProfileModel>[];
  UserProfileModel? userProfileModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  bool isGetLoading =false;
  bool isUpdateLoading =false;
  Future<UserProfileModel?> getUserProfile (String token ,BuildContext context)async{
    userProfileRemoteDataSource.getUserProfile(token, context).then((UserProfileModel? value) {
      userProfileModel=value;
      userProfileModelList.add(value!);
      emit(GetUserProfileTestState(value));

    });
    // emit(GetUserProfileState());

    return null;
  }
  Future<UserProfileModel?> updateUserProfile ( UserProfileModel oldUserProfile ,String token ,BuildContext context)async{
    if(nameController.text.isEmpty&&emailController.text.isEmpty&&phoneController.text.isEmpty&&profileImageFile==null){
      showToast(text: 'please enter your data to need update', state: ToastStates.warning, context: context);
    }else{
      UserProfileModel userProfileModel =UserProfileModel(
          data: Data(
            name: nameController.text.isNotEmpty?nameController.text:oldUserProfile.data!.name,
            email:emailController.text.isNotEmpty?emailController.text:oldUserProfile.data!.email,
            phone: phoneController.text.isNotEmpty?phoneController.text:oldUserProfile.data!.phone,
            phoneCountry: PhoneCountry(
                id: 3
            ),
          )
      );
      userProfileRemoteDataSource.updateProfile(userProfileModel, token, context);
    }
    emit(UpdateUserProfile());
    return null;
  }

  Future<DeleteAccountModel?> deleteAccount (String token ,BuildContext context)async{
    userProfileRemoteDataSource.deleteAccount(token, context);
    emit(DeleteAccountState());
    return null;
  }







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
    });
    emit(AboutCompanyUserState());
  }
  void getTermsAndConditionsUser(BuildContext context)async{
    userProfileRemoteDataSource.getTermsAndConditionsUser(context).then((AboutCompanyModel? value) {
      termsAndConditionsUser =value;
    });
    emit(AboutCompanyUserState());
  }




  File? profileImageFile;

    Future<dynamic> uploadImage()async{
     ImagePicker picker =ImagePicker();
     final XFile? image =await picker.pickImage(source: ImageSource.gallery);
     if(image !=null){
       profileImageFile=File(image.path);
     }
     emit(UploadImage());

    }
   void changeUpdateLoading(bool x){
     isUpdateLoading =x;
     emit(GetUserProfileState());
   }
}
