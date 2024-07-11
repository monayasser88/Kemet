import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/home_cubit_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/governratemodel.dart';
import 'package:kemet/logic/models/offerModel.dart';

import '../logic/models/Homepage.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit({required this.api}) : super(UserDataInitial());

  final ApiConsumer api;

  Future<void> fetchUserData(Dio dio) async {
    try {
      emit(UserDataLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);
      final response = await dio.get(
        EndPoint.profile,
        options: Options(headers: {
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        print(user.firstName);

        emit(UserDataSuccess(user));
      } else {
        // Handle other status codes
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['error'] != null) {
        // Handle validation error from server
        final errorMessage = e.response!.data['error'];
        emit(UserDataError(error: errorMessage));
      } else {
        // Handle other Dio errors
        emit(UserDataError(error: 'An error occurred'));
      }
    } on Exception catch (e) {
      // Handle other exceptions
      emit(UserDataError(error: 'An error occurred'));
    }
  }

  Future<void> governrate(Dio dio) async {
    try {
      emit(governrateLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.get(
        EndPoint.governrates,
        options: Options(headers: {
          'token': token,
        }),
      );
      // final governrate = governrateModel.fromJson(response.data);
      // CacheHelper().saveData(key: ApiKey.idgovernrate, value: governrate.id);

      if (response.statusCode == 200) {
        final List<dynamic> document = response.data['document'];
        List<governrateModel> governrateModels = [];
        final Map<String, String> locationImages = {};
        final List<String> targetLocations = [
          'Giza',
          'Cairo',
          'Aswan',
          'Luxor',
          'Mersa Matruh'
        ];
        document.forEach((location) {
          final String id = location['_id'];
          final String name = location['name'];
          final String image = location['image'];
          if (targetLocations.contains(name)) {
            final governrateModel model = governrateModel(
              id: id,
              image: image,
              name: name,
            );
            governrateModels.add(model);
            CacheHelper().saveData(key: ApiKey.idgovernrate, value: id);
          }
        });

        final governrateModel alexandriaModel = governrateModels.firstWhere(
            (model) => model.name == 'Giza',
            orElse: () => governrateModel(id: '', image: '', name: 'Giza'));
        final governrateModel cairoModel = governrateModels.firstWhere(
            (model) => model.name == 'Cairo',
            orElse: () => governrateModel(id: '', image: '', name: 'Cairo'));
        final governrateModel aswanModel = governrateModels.firstWhere(
            (model) => model.name == 'Aswan',
            orElse: () => governrateModel(id: '', image: '', name: 'Aswan'));
        final governrateModel luxorModel = governrateModels.firstWhere(
            (model) => model.name == 'Luxor',
            orElse: () => governrateModel(id: '', image: '', name: 'Luxor'));
        final governrateModel mersaMatruhModel = governrateModels.firstWhere(
            (model) => model.name == 'Mersa Matruh',
            orElse: () =>
                governrateModel(id: '', image: '', name: 'Mersa Matruh'));
        emit(governrateSuccess(
          alexandria: alexandriaModel,
          cairo: cairoModel,
          aswan: aswanModel,
          luxor: luxorModel,
          mersaMatruh: mersaMatruhModel,
        ));
      } else {
        // Handle other status codes
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['error'] != null) {
        // Handle validation error from server
        final errorMessage = e.response!.data['error'];
        emit(governrateError(error: errorMessage));
      } else {
        // Handle other Dio errors
        emit(governrateError(error: 'An error occurred'));
      }
    } on Exception catch (e) {
      // Handle other exceptions
      emit(governrateError(error: 'An error occurred'));
    }
  }
}
