import 'package:kemet/logic/core/api/end_ponits.dart';

class ErrorModel {
  final String error;
  final String stack;

  ErrorModel({required this.error, required this.stack});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      error: jsonData[ApiKey.error] ?? "",
      stack: jsonData[ApiKey.stack] ?? "",
    );
  }
}
