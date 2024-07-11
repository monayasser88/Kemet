import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/core/errors/exceptions.dart';
import 'package:kemet/models2/favorites_legand.dart';
import 'package:kemet/models2/favorites_tourism.dart';
import 'package:kemet/models2/favorites_trip.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  late WishlistResponse tourismPlace;
  void fetchFavoriteTourismPlaces(Dio dio) async {
    // final token = CacheHelper().getData(key: ApiKey.token);

    // if (token == null) {
    //   emit(FavoriteTripsError('User ID not found in cache.'));
    // }
    emit(FavoriteLoading());
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var response = await dio.get(EndPoint.tourismWishList,
          options: Options(headers: {
            "token": token,
                
          }));
      var wishListTourismPlace = response.data['wishListTourismPlace'] as List;
      if (wishListTourismPlace.isEmpty) {
        emit(FavoritesDeleting());
      } else {
        tourismPlace = WishlistResponse.fromJson(response.data);
        emit(FavoriteSuccess());
      }
    } on ServerException catch (error) {
      print(error.toString());
      emit(FavoriteError('can not load tourism places '));
    }
  }

  void deleteFavoriteTourismPlaces(Dio dio, String favId) async {
    // final token = CacheHelper().getData(key: ApiKey.token);

    // if (token == null) {
    //   emit(FavoriteTripsError('User ID not found in cache.'));
    // }
    emit(FavoriteLoading());
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var response = await dio.delete(EndPoint.deleteTourismWishList(favId),
          options: Options(headers: {
            "token": token,
                
          }));
      if (response.statusCode == 200) {
        //Future.delayed(const Duration(seconds: 2));

        emit(FavoritesDeleting());
        fetchFavoriteTourismPlaces(dio);
      } else {
        emit(FavoriteError('Failed to delete favorite tourism place.'));
      }
    } catch (error) {
      print(error.toString());
      emit(FavoriteError('Failed to delete favorite tourism place.'));
    }
  }

  late WishlistResponseTrip trip = WishlistResponseTrip(
    msg: '',
    wishListTrip: [],
  );
  void fetchFavoriteTrips(Dio dio) async {
    // final token = CacheHelper().getData(key: ApiKey.token);

    // if (token == null) {
    //   emit(FavoriteTripsError('User ID not found in cache.'));
    // }
    emit(FavoriteLoading());
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var response = await dio.get(EndPoint.tripsWishList,
          options: Options(headers: {
            "token": token,
          }));
      var wishListTrip = response.data['wishListTrip'] as List;
      if (wishListTrip.isEmpty) {
        emit(FavoritesDeleting());
      } else {
        trip = WishlistResponseTrip.fromJson(response.data);
        emit(FavoriteSuccess());
      }
    } on ServerException catch (error) {
      print(error.toString());
      emit(FavoriteError('can not load tourism places '));
    }
  }

  void deleteFavoriteTrips(Dio dio, String favId) async {
    // final token = CacheHelper().getData(key: ApiKey.token);

    // if (token == null) {
    //   emit(FavoriteTripsError('User ID not found in cache.'));
    // }
    emit(FavoriteLoading());
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var response = await dio.delete(EndPoint.deleteTripWishList(favId),
          options: Options(headers: {
            "token":token,
                
          }));
      if (response.statusCode == 200) {
        //Future.delayed(const Duration(seconds: 2));

        emit(FavoritesDeleting());
        fetchFavoriteTrips(dio);
      } else {
        emit(FavoriteError('Failed to delete favorite tourism place.'));
      }
    } catch (error) {
      print(error.toString());
      emit(FavoriteError('Failed to delete favorite tourism place.'));
    }
  }

  late WishlistResponseLegand favoriteLegand;
  void fetchFavoriteLegend(Dio dio) async {
    // final token = CacheHelper().getData(key: ApiKey.token);

    // if (token == null) {
    //   emit(FavoriteTripsError('User ID not found in cache.'));
    // }
    emit(FavoriteLoading());
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var response = await dio.get(EndPoint.legendWishList,
          options: Options(headers: {
            "token":token,
          }));
      var wishListLegand = response.data['wishListLegend'] as List;
      if (wishListLegand.isEmpty) {
        emit(FavoritesDeleting());
      } else {
        favoriteLegand = WishlistResponseLegand.fromJson(response.data);
        emit(FavoriteSuccess());
      }
    } on ServerException catch (error) {
      print(error.toString());
      emit(FavoriteError('can not load tourism places '));
    }
  }

  void deleteFavoriteLegend(Dio dio, String favId) async {
    // final token = CacheHelper().getData(key: ApiKey.token);

    // if (token == null) {
    //   emit(FavoriteTripsError('User ID not found in cache.'));
    // }
    emit(FavoriteLoading());
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var response = await dio.delete(EndPoint.deleteLegendWishList(favId),
          options: Options(headers: {
            "token":token,
          }));
      if (response.statusCode == 200) {
        //Future.delayed(const Duration(seconds: 2));

        emit(FavoritesDeleting());
        fetchFavoriteLegend(dio);
      } else {
        emit(FavoriteError('Failed to delete favorite tourism place.'));
      }
    } catch (error) {
      print(error.toString());
      emit(FavoriteError('Failed to delete favorite tourism place.'));
    }
  }
}
