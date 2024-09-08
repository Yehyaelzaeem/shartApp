import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/features/user/auth/data/models/register_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../core/localization/appLocale.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../../shared_screens/notifications/logic/notification_cubit.dart';
import '../../book_package_service/logic/book_package_cubit.dart';
import '../../favorite/logic/favorite_cubit.dart';
import '../../menu/logic/menu_cubit.dart';
import '../../myorders/logic/my_orders_cubit.dart';
import '../../profile/logic/user_profile_cubit.dart';
import '../data/remote_data_base/auth_database.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context)=>BlocProvider.of(context);
  AuthDataSource authDataSource =AuthDataSource();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool visibility = true;
  bool regVisibility = true;
  bool regVisibilityConfirm = true;
  TextEditingController phoneController2 = TextEditingController();
  String token='';
  bool isLoading =false;
  bool isRegLoading =false;
  bool isOtpCompleted =false;
  TextEditingController controllerOtpTest =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController = TextEditingController();
 String otpCode='';
 String textFieldOtp='';
  int type=0;
 void changeType(int x ){
   type=x;
   emit(PutCodeStates());
 }
 void putCode(String x ){
   controllerOtpTest.text=x;
   emit(PutCodeStates());
 }
  Color color=highGreyColor;
  Color color2=Colors.blue;
  void changeColor(Color x){
    color=x;
    emit(PutCodeStates());
  }
  bool isChecked=false;
  void changeCheck(bool x){
    isChecked=x;
    emit(PutCodeStates());
  }
  Future<dynamic> getPermission()async{
    bool service;
    LocationPermission permission;
    service =await Geolocator.isLocationServiceEnabled();
    if(service ==false){
    }
    permission =await Geolocator.checkPermission();
    if(permission ==LocationPermission.denied){
      permission =await Geolocator.requestPermission();
    }
    Position p ;
    p=await Geolocator.getCurrentPosition().then((value) => value);
    List<Placemark> place= await placemarkFromCoordinates( p.latitude,p.longitude);
    CacheHelper.saveDate(key: 'lat', value:  p.latitude.toString());
    CacheHelper.saveDate(key: 'long', value:  p.longitude.toString());
    CacheHelper.saveDate(key: 'city', value:  place[0].administrativeArea);
    emit(GetPermissionStates());
    return permission;
  }
  void userLogin (BuildContext context){
    if(formKey.currentState!.validate()){
      emit(UserLoginLoadingState());
      authDataSource.userLogin(phoneController.text.trim(), '3', passwordController.text.trim(), context).then((value) {
        emit(GetPermissionStates());

      });
    }
  }


  void userRegister (BuildContext context){

    if(registerFormKey.currentState!.validate() ){
      emit(UserRegisterLoadingState());
      if(registerPasswordController.text !=registerConfirmPasswordController.text){
        showToast(text: 'كلمة المرور والتاكد من كلمة المرور ليس متطابقان', state: ToastStates.warning, context: context);
      }
      else
      {
        RegisterData registerData = RegisterData(
          name: registerNameController.text,
          email: registerEmailController.text.trim(),
          phone: registerPhoneController.text.trim(),
          phoneCountryRegisterModel: PhoneCountryRegisterModel(id: 3),
          countryDataRegisterModel: CountryDataRegisterModel(id: 1),
          cityDataRegisterModel: CityDataRegisterModel(id: 1),
          gender: 'male',
          birth_date: '1990-01-01',
          terms_approved: isChecked==true?'1':'0',
        );
        authDataSource.userRegister(registerData, registerConfirmPasswordController.text.trim(), context);
      }
    }

  }


  Locale localeLanguage=Locale(CacheHelper.sharedPreference!.getString('lang')??'ar');
  void changeLanguageApp(dynamic codeLang,BuildContext context,bool isUser){
    localeLanguage =Locale(codeLang);
    CacheHelper.sharedPreference!.setString('lang', codeLang);
   if(isUser ==true){
     MenuCubit.get(context).getPackageCheck(context);
     MyOrdersCubit.get(context).getMyCheckCars(context);
     MyOrdersCubit.get(context).fetchSupplies(context,10,false);
     BookPackageCubit.get(context).getBrands( context: context);
     BookPackageCubit.get(context).getBrandModel(context);
     BookPackageCubit.get(context).getBrandColors(context);
     UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token}',context,);
     UserProfileCubit.get(context).getAboutCompanyUser(context);
     UserProfileCubit.get(context).getTermsAndConditionsUser(context);
     UserProfileCubit.get(context).getPrivacyUser(context);
   }
    emit(ChangeLanguage());
  }


  Future<dynamic> verifyAccount (String code ,BuildContext context)async{
     await  authDataSource.verifyAccount(code, context);
    emit(VerifyAccountState());
  }
  Future<dynamic> sendFCMToken (String token ,String FcmToken )async{
     await  authDataSource.sendFCMToken(token, FcmToken);
    emit(FCMTokenState());
  }
  // void sendCode (BuildContext context){
  //   authDataSource.sendOTP( registerPhoneController.text.trim(), '3', context);
  //   emit(VerifyAccountState());
  // }


  void changeVisibilityIcon(){
    visibility =!visibility;
    emit(ChangeVisibilityIconState());

  }
  void changeRegVisibilityIcon(){
    regVisibility =!regVisibility;
    emit(ChangeVisibilityIconState());
  }
  void changeRegVisibilityIconConfirm(){
    regVisibilityConfirm =!regVisibilityConfirm;
    emit(ChangeVisibilityIconState());
  }

  Future<void> getToken(BuildContext context)async{
   try{
     token = await CacheHelper.getDate(key: 'token');
     // NotificationCubit.get(context).getNotification('user',context);
     UserProfileCubit.get(context).getUserProfile(token, context);
     FavoriteCubit.get(context).getFavoriteProducts(token, context);
     FavoriteCubit.get(context).getFavoriteMerProducts(context);
     MyOrdersCubit.get(context).fetchOrders(context,10,false);
     MyOrdersCubit.get(context).fetchSupplies(context,10,false);
     MyOrdersCubit.get(context).getMyCheckCars(context);
   }catch(e){
     print('error token $e');
   }
    emit(GetTokenState());
  }
  Future<dynamic> forgetPassword(BuildContext context,)async{
    if(phoneController2.text.isNotEmpty){
      authDataSource.forgetPassword(phoneController2.text,'3', context,);
      emit(ResetPasswordState());
    }else{
      showToast(text: '${getLang(context, 'complete_data')}', state: ToastStates.error, context: context);
    }
  }

  Future<dynamic> resetPassword(String code,BuildContext context,)async{
    authDataSource.resetPassword(code, context,);
    emit(ResetPasswordState());
  }

  void loginLoadingStates(bool x){
    isLoading =x;
    emit(LoginLoadingStates());
  }
  void loginRegLoadingStates(bool x){
    isRegLoading =x;
    emit(LoginLoadingStates());
  }
  void changeOtpCompleted(bool x){
    isOtpCompleted =x;
    emit(ChangeOtpCompleted());
  }



}
