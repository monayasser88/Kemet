import 'package:kemet/logic/core/api/end_ponits.dart';

class ForgetVerificationModel {
  final String msg;
  //final String token;


  ForgetVerificationModel({required this.msg});
  factory ForgetVerificationModel.fromJson(Map<String, dynamic> jsonData) {
    return ForgetVerificationModel(
      msg: jsonData[ApiKey.msg],
    //  token: jsonData[ApiKey.token]
      );
  }
}