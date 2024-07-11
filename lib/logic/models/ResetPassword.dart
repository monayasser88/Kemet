import 'package:kemet/logic/core/api/end_ponits.dart';

class ResetPasswordModel {
  final String msg;
  //final String token;


  ResetPasswordModel({required this.msg});
  factory ResetPasswordModel.fromJson(Map<String, dynamic> jsonData) {
    return ResetPasswordModel(
      msg: jsonData[ApiKey.msg],
    //  token: jsonData[ApiKey.token]
      );
  }
}