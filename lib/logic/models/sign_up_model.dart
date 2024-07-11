import 'package:kemet/logic/core/api/end_ponits.dart';

class SignUpModel {
  final String msg;
  final String token;

  SignUpModel({required this.token, required this.msg});
  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpModel(msg: jsonData[ApiKey.msg], token: jsonData[ApiKey.token]);
  }
}
