import 'package:kemet/logic/core/api/end_ponits.dart';

class createpasswordModel {
  final String msg;
  //final String token;


  createpasswordModel({required this.msg});
  factory createpasswordModel.fromJson(Map<String, dynamic> jsonData) {
    return createpasswordModel(
      msg: jsonData[ApiKey.msg],
    //  token: jsonData[ApiKey.token]
      );
  }
}