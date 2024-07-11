import 'package:kemet/logic/core/api/end_ponits.dart';

class EmailForgetModel {
  final String msg;
  //final String token;


  EmailForgetModel({required this.msg});
  factory EmailForgetModel.fromJson(Map<String, dynamic> jsonData) {
    return EmailForgetModel(
      msg: jsonData[ApiKey.msg],
    //  token: jsonData[ApiKey.token]
      );
  }
}