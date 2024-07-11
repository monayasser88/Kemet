import 'package:kemet/logic/core/api/end_ponits.dart';

class SignInModel {
  final String msg;
  final String token;


  SignInModel({required this.msg,required this.token});
  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      msg: json['msg'],
      token: json['token']
      );
  }
}