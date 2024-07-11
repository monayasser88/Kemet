import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/sign_in_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/signin.dart';

class SignInCubit extends Cubit<SignInstate> {
  SignInCubit({required this.api}) : super(SignInInitial());

  GlobalKey<FormState> SignInFormKey = GlobalKey();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  final ApiConsumer api;

  Future<void> Sign_In(Dio dio) async {

    try {
      emit(SignInLoading());
      // final token = CacheHelper().getDataString(key: ApiKey.token);
      final response = await dio.post(
        EndPoint.signin,
        data: {
          ApiKey.email: EmailController.text,
          ApiKey.password: PasswordController.text,
        },
        // options: Options(headers: {
        //   'token': token,
        // }),
      );
      // final signinModel = SignInModel.fromJson(response as Map<String, dynamic>);

//      CacheHelper().saveData(key: ApiKey.token, value: response.data['token']);

      if (response.statusCode == 200) {
        final signinModel = SignInModel.fromJson(response.data);
        CacheHelper().saveData(key: ApiKey.token, value: response.data['token']);
        emit(SignInSuccess(msg: signinModel.msg, token: response.data['token']));
      } else {
        // Handle other status codes
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: deprecated_member_use
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data['error'] != null) {
          final errorMessage = e.response!.data['error'];
          print(errorMessage);
          emit(SignInError(error: errorMessage));
        } else {
          emit(SignInError(error: 'An error occurred'));
        }
      } else {
        // Handle other exceptions
        emit(SignInError(error: 'An error occurred'));
      }
    }
  }
}
