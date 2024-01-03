import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/provider/auth/data/models/register_provider_model.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../user/profile/logic/user_profile_cubit.dart';
import '../../profile/logic/provider_profile_cubit.dart';
import '../data/remote_data_base/auth_provider_database.dart';
part 'auth_provider_state.dart';

class AuthProviderCubit extends Cubit<AuthProviderState> {
  AuthProviderCubit() : super(AuthProviderInitial());

  static AuthProviderCubit get(BuildContext context)=>BlocProvider.of(context);
  AuthProviderDataSource authProviderDataSource =AuthProviderDataSource();
  final GlobalKey<FormState> formKeyProvider = GlobalKey<FormState>();

  final GlobalKey<FormState> registerFormKeyProvider = GlobalKey<FormState>();
  bool visibility = true;
  bool regVisibility = true;
  bool regVisibilityConfirm = true;

  // String tokenTest='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiMDk2ZDE0MWQzZDZlNWY1YjhjYjFjMWQ0NDk1NDQ1OTNkODhjYjk1OWZlYWE2NmY4NDI1MDJjMzlmZjBjNDkxYTI2YzkwOTM3NjgwNzAxZTgiLCJpYXQiOjE3MDMxNDYyMTguNTk5OTUwMDc1MTQ5NTM2MTMyODEyNSwibmJmIjoxNzAzMTQ2MjE4LjU5OTk1MTAyODgyMzg1MjUzOTA2MjUsImV4cCI6MTczNDc2ODYxOC41OTQwOTMwODQzMzUzMjcxNDg0Mzc1LCJzdWIiOiIxMzMiLCJzY29wZXMiOltdfQ.SrPQ0UQrkQMuB-56f0BAfxKgQQ1PRm3fhrkmRqUpT2wfW4sIyePeqHFta7o_f8K-jrfF88M92Ivp9y7WELfjxjSEdTJ09LvTyVdUr5FbJbLfEFZ7fHbniLo1zeriV0FVUrqTarWfhN94BaK1ru7hvY7BO1djLN7EJpOM59zT34ynmFcsIxGhWe2i_GuDt68reF-h8jCZHAtMVqGjpfdVS5QANC2i_QlCKpYG1e3o2YBV_RdkwmUZ1l--sNOyee_duIkuLqZDYgSii6MFWyYkdbEzRSMCFWW9tPEYRu25BPCzuvtblxaVgGj-tcLraiN7BYtJ_J6eQyHLN4g96HSp2GePp4AnLpaQCTjCBXZrOdgwl6HZJ3uaggBVP82cs1ouHShY9k5lzUjHrnA2bqxizpEQoaE2bf1RvDWXIIC_wkC-g9XEA4zlF7EjlZ_ig5EWp10bv9UGiZB9qgtnIOqkFRo8Faz8kT9Mf49MGgBnPop6AaiBmWxzPTs1oLrNejNPMQUslfUKZhYmrVv3z3FNuX6yI-pnk8dVp-Tblymbky4gRZY62cT9VMGaj0q1iJ_7uuTEx_q-w_l8lVNkXDiajj8tJ4QU6UbdX_sDCEMZyPzlFX1gSvyPfOUfAE5NWgKgiSSSNul8Q8xvFdPO-Ds9z8zX4gA0DEt8zuZFhrZ3VNs';
  String token='';
  String token2='';
  bool isLoading =false;
  bool isRegLoading =false;
  bool isOtpCompleted =false;
  TextEditingController phoneControllerProvider =TextEditingController();
  TextEditingController passwordControllerProvider =TextEditingController();
  TextEditingController registerNameControllerProvider = TextEditingController();
  TextEditingController registerEmailControllerProvider = TextEditingController();
  TextEditingController registerPhoneControllerProvider = TextEditingController();
  TextEditingController registerPasswordControllerProvider = TextEditingController();
  TextEditingController registerConfirmPasswordControllerProvider = TextEditingController();
 String otpCode='';
 String textFieldOtp='';

 void getToken(context)async{
    token = await CacheHelper.getDate(key: 'providerToken');
    print('CacheHelper : ${token}');
    ProviderProfileCubit.get(context).getProviderProfile('${token}', context);
    ProviderProfileCubit.get(context).getAddressListProvider(token, context);

    emit(GetTokenState());
 }


  void providerLogin (BuildContext context){
    if(formKeyProvider.currentState!.validate()){
      authProviderDataSource.providerLogin(phoneControllerProvider.text.trim(), '3', passwordControllerProvider.text.trim(), context);
    }
    emit(ProviderLoginState());
  }


  void providerRegister (BuildContext context){
    if(registerFormKeyProvider.currentState!.validate() ){
      if(registerPasswordControllerProvider.text !=registerConfirmPasswordControllerProvider.text){
        showToast(text: 'كلمة المرور والتاكد من كلمة المرور ليس متطابقان', state: ToastStates.warning, context: context);
      }
      else
      {
        ProviderRegisterData registerData =ProviderRegisterData(
          name: registerNameControllerProvider.text,
          email: registerEmailControllerProvider.text.trim(),
          phone: registerPhoneControllerProvider.text.trim(),
          phoneCountry: PhoneCountry(id: 3),
        );
        authProviderDataSource.providerRegister(registerData, registerConfirmPasswordControllerProvider.text.trim(), context);
      }

    }
    emit(ProviderRegisterState());
  }




  void providerVerifyAccount (String code ,BuildContext context){
    authProviderDataSource.providerVerifyAccount(code, context);
    emit(ProviderVerifyAccountState());
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


  void loginLoadingStates(bool x){
    isLoading =x;
    emit(ProviderLoginLoadingStates());
  }
  void loginRegLoadingStates(bool x){
    isRegLoading =x;
    emit(ProviderLoginLoadingStates());
  }
  void changeOtpCompleted(bool x){
    isOtpCompleted =x;
    emit(ProviderChangeOtpCompleted());
  }


}
