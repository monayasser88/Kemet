import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/create_password_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/createpassword.dart';

class createpasswordCubit extends Cubit<createpasswordstate> {
  createpasswordCubit({required this.api}) : super(createpasswordInitial());

  GlobalKey<FormState> createpasswordFormKey = GlobalKey();
  final TextEditingController createpasswordController =
      TextEditingController();
  final TextEditingController createrepasswordController =
      TextEditingController();
  final ApiConsumer api;

  //String? verficationEmailModel;
  Future<void> createpassword(Dio dio) async {
    try {
      emit(createpasswordLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);
      final response = await dio.post(
        EndPoint.setingPassword,
        data: {
          ApiKey.password: createpasswordController.text,
          ApiKey.rePassword: createrepasswordController.text,
        },
        options: Options(headers: {
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        final CreatePasswordModel = createpasswordModel.fromJson(response.data);
        emit(createpasswordSuccess(msg: CreatePasswordModel.msg));
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
        emit(createpasswordError(error: errorMessage));
      } else {
        // Handle other Dio errors
        emit(createpasswordError(error: 'An error occurred'));
      }
    } on Exception catch (e) {
      // Handle other exceptions
      emit(createpasswordError(error: 'An error occurred'));
    }
  }
}
