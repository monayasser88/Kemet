import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/sign_in_state.dart';
import 'package:kemet/cubit/verification_forget_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/models/ForgetVerification.dart';
import 'package:kemet/logic/models/signin.dart';

class ForgetVerificationCubit extends Cubit<ForgetVerificationstate> {
  ForgetVerificationCubit({required this.api})
      : super(ForgetVerificationInitial());

  GlobalKey<FormState> ForgetVerificationFormKey = GlobalKey();
 final TextEditingController ForgetVerificationController = TextEditingController();


  final ApiConsumer api;

  Future<void> Forget_Verification (Dio dio) async {
    try {
     
      emit(ForgetVerificationLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);
      final response = await dio.post(
        EndPoint.checkpinCode,
        data: {
          ApiKey.pinCode: ForgetVerificationController.text,
        },
        options: Options(headers: {
          'token': token,
        }),
      );
if (response.statusCode == 200) {
        final forgetVerificationModel = ForgetVerificationModel.fromJson(response.data);
        emit(ForgetVerificationSuccess(msg: forgetVerificationModel.msg));
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
          emit(ForgetVerificationError(error: errorMessage));
        } else {
          emit(ForgetVerificationError(error: 'An error occurred'));
        }
      } else {
        // Handle other exceptions
        emit(ForgetVerificationError(error: 'An error occurred'));
      }
    }
  }
}

