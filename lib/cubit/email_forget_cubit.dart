import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/email_forget_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/EmailForget.dart';

class EmailForgetCubit extends Cubit<EmailForgetstate> {
  EmailForgetCubit({required this.api})
      : super(EmailForgetInitial());

  GlobalKey<FormState> EmailForgetFormKey = GlobalKey();
 final TextEditingController EmailForgetController = TextEditingController();
  final ApiConsumer api;

  Future<void> Email_Forget (Dio dio) async {
    try {
     
      emit(EmailForgetLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);
      final response = await dio.post(
        EndPoint.forgettingPassword,
        data: {
          ApiKey.email: EmailForgetController.text,
         
        },
        // options: Options(headers: {
        //   'token': token,
        // }
        // ),
      );
if (response.statusCode == 200) {
        final emailForgetModel = EmailForgetModel.fromJson(response.data);
        emit(EmailForgetSuccess(msg: emailForgetModel.msg));
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
          emit(EmailForgetError(error: errorMessage));
        } else {
          emit(EmailForgetError(error: 'An error occurred'));
        }
      } else {
        // Handle other exceptions
        emit(EmailForgetError(error: 'An error occurred'));
      }
    }
  }
}

