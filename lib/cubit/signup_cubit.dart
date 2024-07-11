import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/signup_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/core/errors/exceptions.dart';
import 'package:kemet/logic/models/sign_up_model.dart';

class SignEmailCubit extends Cubit<SignEmailState> {
  SignEmailCubit({required this.api}) : super(SignEmailInitial());

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  final TextEditingController signUpEmailController = TextEditingController();

  final ApiConsumer api;
   
  Future<void> signUp() async {
    try {
      if (signUpFormKey.currentState == null ||
          !signUpFormKey.currentState!.validate()) {
        // Form validation failed or currentState is null, return early
        return;
      }
      emit(SignEmailLoading());
      final response = await api.post(
        EndPoint.verifyEmail,
        data: {
          ApiKey.email: signUpEmailController.text,
        },
      );
      final signUpModel = SignUpModel.fromJson(response);
             

      // final decodedToken = JwtDecoder.decode(signUpModel.token);
      //print(decodedToken['userId']);
       CacheHelper().saveData(key: ApiKey.token, value: signUpModel.token);
      // CacheHelper()
      //     .saveData(key: ApiKey.userId, value: decodedToken[ApiKey.userId]);
      emit(SignEmailSuccess(msg: signUpModel.msg));
    } on ServerException catch (e) {
      emit(SignEmailError(error: e.errModel.error));
    }
  }
}
