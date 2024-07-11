import 'package:dio/dio.dart';
import 'package:kemet/logic/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  if (e.response != null && e.response!.data != null) {
    final jsonData = e.response!.data as Map<String, dynamic>;
    final errorModel = ErrorModel.fromJson(jsonData);
    throw ServerException(errModel: errorModel);
  } else {
    // Handle generic Dio exceptions
    throw ServerException(
        errModel: ErrorModel(
      error: e.message ?? "Unknown Error",
      stack: "",
    ));
  }
}
