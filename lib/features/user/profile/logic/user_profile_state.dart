part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}
class GetUserProfileState extends UserProfileState {}
class GetUserProfileTestState extends UserProfileState {
  final UserProfileModel userProfileModel;
  GetUserProfileTestState(this.userProfileModel);
}
class UploadImage extends UserProfileState {}
class DeleteAccountState extends UserProfileState {}
class UpdateUserProfile extends UserProfileState {}
class AboutCompanyUserState extends UserProfileState {}

