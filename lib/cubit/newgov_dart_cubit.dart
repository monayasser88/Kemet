import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/home_cubit_state.dart';
import 'package:kemet/cubit/newgov_dart_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/newgov.dart';

class UserDataCubitnew extends Cubit<UserDataStatenew> {
  final DioConsumer api;

  UserDataCubitnew({required this.api}) : super(UserDataInitialnew());

  Future<void> fetchGovernoratesnew(Dio dio) async {
    try {
      emit(GovernrateLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.get(
        EndPoint.governrates,
        options: Options(headers: {
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> document = response.data['document'];
        List<NewGovernrateModel> governrateModels = document
            .take(5) // Take the first 5 items
            .map((location) => NewGovernrateModel(
                  id: location['_id'],
                  image: location['image'],
                  name: location['name'],
                ))
            .toList();

        governrateModels.forEach((model) {
          CacheHelper().saveData(key: ApiKey.idgovernrate, value: model.id);
          print('ID already exists in cache: ${model.id}');
        });

        emit(GovernrateSuccess(governorates: governrateModels));
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['error'] != null) {
        final errorMessage = e.response!.data['error'];
        emit(GovernrateError(error: errorMessage));
      } else {
        emit(GovernrateError(error: 'An error occurred'));
      }
    } on Exception catch (e) {
      emit(GovernrateError(error: 'An error occurred'));
    }
  }
}
