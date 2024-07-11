part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}
final class FavoriteSuccess extends FavoritesState {
}
final class FavoriteLoading extends FavoritesState {}
final class FavoritesDeleting extends FavoritesState {}
final class FavoriteError extends FavoritesState {
  final String errMassage;

  FavoriteError(this.errMassage);
}
