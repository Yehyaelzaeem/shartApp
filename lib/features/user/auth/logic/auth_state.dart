part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class GetTokenState extends AuthState {}
class UserLoginState extends AuthState {}
class GetPermissionStates extends AuthState {}
class UserRegisterState extends AuthState {}
class ChangeLanguage extends AuthState {}
class VerifyAccountState extends AuthState {}
class ChangeOtpCompleted extends AuthState {}
class LoginLoadingStates extends AuthState {}
class ChangeVisibilityIconState extends AuthState {}

