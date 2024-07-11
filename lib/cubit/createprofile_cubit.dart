import 'dart:io';
 import 'package:http_parser/http_parser.dart';
  import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kemet/cubit/createprofile_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/api_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/core/functions/upload_images_to_api.dart';
import 'package:kemet/logic/models/createprofile.dart';

class createprofileCubit extends Cubit<createprofilestate> {
  // var path;

  createprofileCubit({required this.api}) : super(createprofileInitial());

  GlobalKey<FormState> createprofileFormKey = GlobalKey();
  final TextEditingController createfirstnameController =
      TextEditingController();
  final TextEditingController createrelastnameController =
      TextEditingController();
  final TextEditingController createcityController = TextEditingController();
  final TextEditingController createdateController = TextEditingController();
  final ApiConsumer api;

  XFile? profilePic;

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  Future<void> createprofile(Dio dio) async {
    try {
      emit(createprofileLoading());
      final token = CacheHelper().getDataString(key: ApiKey.token);
     if (profilePic == null) {
        throw Exception('Profile picture is required.');
      }
      MultipartFile file = await MultipartFile.fromFile(
        profilePic!.path,
        filename: path.basename(profilePic!.path),
        contentType: MediaType(
          'image',
          path.extension(profilePic!.path).substring(1),
        ),
      );
      // if (profilePic == null) {
      //   throw Exception('Profile picture is required.');
      // }
      //  FormData formData = await UploadImageToApi(profilePic! as File);

      // Create FormData object
      //  File profileImageFile = File(profilePic!.path);

      FormData formData = FormData.fromMap({
        ApiKey.firstName: createfirstnameController.text,
        ApiKey.lastName: createrelastnameController.text,
        ApiKey.DOB: createdateController.text,
        ApiKey.city: createcityController.text,
        //ApiKey.profileImg: await MultipartFile.fromFile(profilePic!.path, filename: 'profileImg'),

        ApiKey.profileImg: file,
        // await MultipartFile.fromFile(profilePic!.path,
        //     filename: 'profileImg'),
      });

      final response = await dio.post(
        EndPoint.signup,
        data: formData,
        options: Options(headers: {
          'token': token,
        }),
      );
      print(response);
      if (response.statusCode == 200) {
        final createprofileModel = CreateProfileModel.fromJson(response.data);
        emit(createprofileSuccess(msg: createprofileModel.msg));
      } else {
        // Handle other status codes
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: deprecated_member_use
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data['error'] != null) {
          final errorMessage = e.response!.data['error'];
          emit(createprofileError(error: errorMessage));
        } else {
          emit(createprofileError(error: 'An error occurred'));
        }
      } else {
        // Handle other exceptions
        emit(createprofileError(error: 'An error occurred'));
      }
    }
  }
}
