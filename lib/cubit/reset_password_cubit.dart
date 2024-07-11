import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/reset_password_state.dart';
import 'package:kemet/cubit/sign_in_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/ResetPassword.dart';
import 'package:kemet/logic/models/signin.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordstate> {
  ResetPasswordCubit({required this.api})
      : super(ResetPasswordInitial());

  GlobalKey<FormState> ResetPasswordFormKey = GlobalKey();
 final TextEditingController ResetPasswordController = TextEditingController();

  final ApiConsumer api;

  Future<void> Reset_Password (Dio dio) async {
    try {
     final token = CacheHelper().getDataString(key: ApiKey.token);
      emit(ResetPasswordLoading());
      final response = await dio.post(
        EndPoint.resetPassword,
        data: {
          ApiKey.newPassword: ResetPasswordController.text,
          
        },
        options: Options(headers: {
          'token': token,
        }
        ),
      );
if (response.statusCode == 200) {
        final resetPasswordModel = ResetPasswordModel.fromJson(response.data);
        CacheHelper().saveData(key: ApiKey.token, value: response.data['token']);
        emit(ResetPasswordSuccess(msg: resetPasswordModel.msg));
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
          emit(ResetPasswordError(error: errorMessage));
        } else {
          emit(ResetPasswordError(error: 'An error occurred'));
        }
      } else {
        // Handle other exceptions
        emit(ResetPasswordError(error: 'An error occurred'));
      }
    }
  }
}

