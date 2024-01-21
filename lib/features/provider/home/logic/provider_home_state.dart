part of 'provider_home_cubit.dart';

@immutable
abstract class ProviderHomeState {}

class ProviderHomeInitial extends ProviderHomeState {}
class GetPackagesState extends ProviderHomeState {}
class SubscribePackagesState extends ProviderHomeState {}
class HistoryPackagesState extends ProviderHomeState {}
class ChangeLoadingState extends ProviderHomeState {}
