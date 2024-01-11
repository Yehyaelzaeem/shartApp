import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/provider/auth/logic/auth_provider_cubit.dart';
import 'package:shart/features/user/auth/data/models/register_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../book_package_service/logic/book_package_cubit.dart';
import '../../menu/logic/menu_cubit.dart';
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

  // String tokenTest='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiMDk2ZDE0MWQzZDZlNWY1YjhjYjFjMWQ0NDk1NDQ1OTNkODhjYjk1OWZlYWE2NmY4NDI1MDJjMzlmZjBjNDkxYTI2YzkwOTM3NjgwNzAxZTgiLCJpYXQiOjE3MDMxNDYyMTguNTk5OTUwMDc1MTQ5NTM2MTMyODEyNSwibmJmIjoxNzAzMTQ2MjE4LjU5OTk1MTAyODgyMzg1MjUzOTA2MjUsImV4cCI6MTczNDc2ODYxOC41OTQwOTMwODQzMzUzMjcxNDg0Mzc1LCJzdWIiOiIxMzMiLCJzY29wZXMiOltdfQ.SrPQ0UQrkQMuB-56f0BAfxKgQQ1PRm3fhrkmRqUpT2wfW4sIyePeqHFta7o_f8K-jrfF88M92Ivp9y7WELfjxjSEdTJ09LvTyVdUr5FbJbLfEFZ7fHbniLo1zeriV0FVUrqTarWfhN94BaK1ru7hvY7BO1djLN7EJpOM59zT34ynmFcsIxGhWe2i_GuDt68reF-h8jCZHAtMVqGjpfdVS5QANC2i_QlCKpYG1e3o2YBV_RdkwmUZ1l--sNOyee_duIkuLqZDYgSii6MFWyYkdbEzRSMCFWW9tPEYRu25BPCzuvtblxaVgGj-tcLraiN7BYtJ_J6eQyHLN4g96HSp2GePp4AnLpaQCTjCBXZrOdgwl6HZJ3uaggBVP82cs1ouHShY9k5lzUjHrnA2bqxizpEQoaE2bf1RvDWXIIC_wkC-g9XEA4zlF7EjlZ_ig5EWp10bv9UGiZB9qgtnIOqkFRo8Faz8kT9Mf49MGgBnPop6AaiBmWxzPTs1oLrNejNPMQUslfUKZhYmrVv3z3FNuX6yI-pnk8dVp-Tblymbky4gRZY62cT9VMGaj0q1iJ_7uuTEx_q-w_l8lVNkXDiajj8tJ4QU6UbdX_sDCEMZyPzlFX1gSvyPfOUfAE5NWgKgiSSSNul8Q8xvFdPO-Ds9z8zX4gA0DEt8zuZFhrZ3VNs';
  String token='';
  // String token2='';
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

  Future getPermission()async{
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
      authDataSource.userLogin(phoneController.text.trim(), '3', passwordController.text.trim(), context);
    }
    emit(UserLoginState());
  }


  void userRegister (BuildContext context){
    if(registerFormKey.currentState!.validate() ){
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
          birth_date: '1990-01-01'
        );
        authDataSource.userRegister(registerData, registerConfirmPasswordController.text.trim(), context);
      }
    }
    emit(UserRegisterState());
  }


  Locale localeLanguage=Locale(CacheHelper.sharedPreference!.getString('lang')??'ar');
  void changeLanguageApp(dynamic codeLang,BuildContext context,bool isUser){
    localeLanguage =Locale(codeLang);
    CacheHelper.sharedPreference!.setString('lang', codeLang);
   if(isUser ==true){
     MenuCubit.get(context).getPackageCheck(context);
     BookPackageCubit.get(context).getBrands(context);
     BookPackageCubit.get(context).getBrandModel(context);
     BookPackageCubit.get(context).getBrandColors(context);
     UserProfileCubit.get(context).getUserProfile('${AuthCubit.get(context).token}',context,);
     UserProfileCubit.get(context).getAboutCompanyUser(context);
     UserProfileCubit.get(context).getTermsAndConditionsUser(context);
     UserProfileCubit.get(context).getPrivacyUser(context);
   }
    emit(ChangeLanguage());
  }


  void verifyAccount (String code ,BuildContext context){
    authDataSource.verifyAccount(code, context);
    emit(VerifyAccountState());
  }


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
  void getToken(BuildContext context)async{
    print('start');
    token = await CacheHelper.getDate(key: 'token');
    UserProfileCubit.get(context).getUserProfile(token, context);
    emit(GetTokenState());
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
