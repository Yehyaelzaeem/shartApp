part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}
class GetFavoritesState extends FavoriteState {}
class AddAndRemoveFavoritesState extends FavoriteState {}
class ChangeIconFavoritesState extends FavoriteState {}
