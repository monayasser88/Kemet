import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/verification_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/verificationEmail.dart';

class verificationEmailCubit extends Cubit<verificationEmailstate> {
  verificationEmailCubit({required this.api})
      : super(verificationEmailInitial());

  GlobalKey<FormState> verificationEmailFormKey = GlobalKey();
  final TextEditingController verificationEmailController =
      TextEditingController();

  final ApiConsumer api;

  Future<void> verification_Email(Dio dio) async {
    try {
     
      emit(verificationEmailLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);
      final response = await dio.post(
        EndPoint.checkConformingEmail,
        data: {
          ApiKey.pinCode: verificationEmailController.text,
        },
        options: Options(headers: {
          'token': token,
        }),
      );

     if (response.statusCode == 200) {
        final verificationEmailModel = VerficationEmailModel.fromJson(response.data);
        emit(verificationEmailSuccess(msg: verificationEmailModel.msg));
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
          emit(verificationEmaillError(error: errorMessage));
        } else {
          emit(verificationEmaillError(error: 'An error occurred'));
        }
      } else {
        // Handle other exceptions
        emit(verificationEmaillError(error: 'An error occurred'));
      }
    }
  }
}

