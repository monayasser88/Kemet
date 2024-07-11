import 'package:kemet/logic/core/api/end_ponits.dart';

class VerficationEmailModel {
  final String msg;
  //final String token;


  VerficationEmailModel({required this.msg});
  factory VerficationEmailModel.fromJson(Map<String, dynamic> jsonData) {
    return VerficationEmailModel(
      msg: jsonData[ApiKey.msg],
    //  token: jsonData[ApiKey.token]
      );
  }
}