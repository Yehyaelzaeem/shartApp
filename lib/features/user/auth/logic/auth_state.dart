part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class GetTokenState extends AuthState {}
class UserLoginLoadingState extends AuthState {}
class UserLoginSuccessState extends AuthState {}
class UserLoginErrorState extends AuthState {}
class GetPermissionStates extends AuthState {}
class PutCodeStates extends AuthState {}
class UserRegisterLoadingState extends AuthState {}
class UserRegisterState extends AuthState {}
class ChangeLanguage extends AuthState {}
class VerifyAccountState extends AuthState {}
class FCMTokenState extends AuthState {}
class ChangeOtpCompleted extends AuthState {}
class LoginLoadingStates extends AuthState {}
class ResetPasswordState extends AuthState {}
class ChangeVisibilityIconState extends AuthState {}
class ChangePasswordVisibility extends AuthState {}

