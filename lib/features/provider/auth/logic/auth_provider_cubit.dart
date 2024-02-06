import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/provider/auth/data/models/register_provider_model.dart';
import 'package:shart/widgets/show_toast_widget.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../myorders/logic/provider_orders_cubit.dart';
import '../../profile/logic/provider_profile_cubit.dart';
import '../../work_and_products/logic/work_products_cubit.dart';
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
  String token='';
  String token2='';
  bool isLoading =false;
  bool isRegLoading =false;
  bool isOtpCompleted =false;
  TextEditingController controllerOtpTest =TextEditingController();
  TextEditingController phoneControllerProvider =TextEditingController();
  TextEditingController passwordControllerProvider =TextEditingController();
  TextEditingController registerNameControllerProvider = TextEditingController();
  TextEditingController registerEmailControllerProvider = TextEditingController();
  TextEditingController registerPhoneControllerProvider = TextEditingController();
  TextEditingController registerPasswordControllerProvider = TextEditingController();
  TextEditingController registerConfirmPasswordControllerProvider = TextEditingController();
 String otpCode='';
 String textFieldOtp='';

 void getToken(BuildContext context)async{
    token = await CacheHelper.getDate(key: 'providerToken');
    ProviderProfileCubit.get(context).getProviderProfile('${token}', context);
    ProviderProfileCubit.get(context).getAddressListProvider(token, context);
    WorkProductsCubit.get(context).getWorks(context);
    WorkProductsCubit.get(context).getAllProducts(context);
    ProviderOrdersCubit.get(context).getMyOrdersCurrentProvider(context);
    ProviderOrdersCubit.get(context).getMyOrdersPreviousProvider(context);
    ProviderOrdersCubit.get(context).getMyOrdersCancelledProvider(context);
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
