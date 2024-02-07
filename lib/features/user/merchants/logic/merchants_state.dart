part of 'merchants_cubit.dart';

@immutable
abstract class MerchantsState {}

class MerchantsInitial extends MerchantsState {}
class GetMerchantsState extends MerchantsState {}
class FavoriteMerchantsState extends MerchantsState {}
