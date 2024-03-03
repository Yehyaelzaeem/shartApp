part of 'auth_provider_cubit.dart';

@immutable
abstract class AuthProviderState {}

class AuthProviderInitial extends AuthProviderState {}
class ProviderLoginState extends AuthProviderState {}
class GetTokenState extends AuthProviderState {}
class ProviderRegisterState extends AuthProviderState {}
class ProviderVerifyAccountState extends AuthProviderState {}
class ProviderChangeOtpCompleted extends AuthProviderState {}
class ResetPasswordState extends AuthProviderState {}
class ProviderLoginLoadingStates extends AuthProviderState {}
class ChangeVisibilityIconState extends AuthProviderState {}
class ChangeLanguageState extends AuthProviderState {}
