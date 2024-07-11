import 'package:kemet/logic/core/api/end_ponits.dart';

class CreateProfileModel {
  final String msg;
  //final String token;


  CreateProfileModel({required this.msg});
  factory CreateProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return CreateProfileModel(
      msg: jsonData[ApiKey.msg],
    //  token: jsonData[ApiKey.token]
      );
  }
}