import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/logic/core/errors/exceptions.dart';
import 'package:kemet/models2/user_model.dart';
import 'package:path/path.dart' as path;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  XFile? profilePic;
  updateProfilePic(XFile image) {
    profilePic = image;
    emit(UploadPicture());
  }

  Profile? profileIns;
  Future getUserProfile(Dio dio) async {
    if (state is! ProfileLoading) {
      emit(ProfileLoading());
    }
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.get(
        'https://kemet-gp2024.onrender.com/api/v1/auth/profile',
        options: Options(headers: {
          'token': token,
        }),
      );
      final profile = Profile.fromJson(response.data);
      if (state is! ProfileError) {
        emit(ProfileLoaded(profile));
      }
    } on ServerException catch (e) {
      if (state is! ProfileError) {
        emit(ProfileError('Failed to fetch user profile'));
      }
    }
  }

  void refreshProfile() {
    getUserProfile(Dio());
  }

  void updateFirstName(String firstName, Dio dio,
      TextEditingController firstNameController) async {
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var updatedFirstNameResponse = await dio.put(
        'https://kemet-gp2024.onrender.com/api/v1/auth/updateProfile',
        data: {'firstName': firstName},
        options: Options(headers: {
          'token':token,
        }),
      );
      print('Response Status Code: ${updatedFirstNameResponse.statusCode}');
      print('Response Data: ${updatedFirstNameResponse.data}');
      print(
          'first name: ${updatedFirstNameResponse.data['user']['firstName']}');
      if (updatedFirstNameResponse.statusCode == 200) {
        getUserProfile(dio);
        final updatedProfile = Profile.fromJson(updatedFirstNameResponse.data);
        Future.microtask(() {
          emit(ProfileLoaded(updatedProfile));
          firstNameController.text = updatedProfile.firstName ?? '';
        });
      } else {
        emit(ProfileError('Failed to fetch updated profile.'));
      }
    } on ServerException catch (e) {
      print('Error updating first name: $e');
      emit(ProfileError('Error updating first name: $e'));
    }
  }

  Future uploadImageToApi(XFile image) async {
    try {
      Dio dio = Dio();
      MultipartFile file = await MultipartFile.fromFile(
        image.path,
        filename: path.basename(image.path),
        contentType:
            MediaType('image', path.extension(image.path).substring(1)),
      );
      FormData formData = FormData.fromMap({'profileImg': file});
            final token = CacheHelper().getDataString(key: ApiKey.token);

      Response response = await dio.put(
        'https://kemet-gp2024.onrender.com/api/v1/auth/updateProfile',
        data: formData,
        options: Options(headers: {
          'token':token,
        }),
      );
      if (response.statusCode == 200) {
        final updatedProfile = Profile.fromJson(response.data);
        emit(ProfileLoaded(updatedProfile));
      } else {
        print('Failed to upload image. Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        return null;
      }
    } on ServerException catch (e) {
      emit(ProfileError(e.errModel.error));
    }
  }

  void updateLastName(String lastName, Dio dio,
      TextEditingController lastNameController) async {
    final token = CacheHelper().getData(key: ApiKey.token);
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var updatedLastNameResponse = await dio.put(
        'https://kemet-gp2024.onrender.com/api/v1/auth/updateProfile',
        data: {'lastName': lastName},
        options: Options(headers: {
          'token':token,
        }),
      );
      print('Response Status Code: ${updatedLastNameResponse.statusCode}');
      print('Response Data: ${updatedLastNameResponse.data}');
      print('last name: ${updatedLastNameResponse.data['user']['lastName']}');
      if (updatedLastNameResponse.statusCode == 200) {
        getUserProfile(dio);
        final updatedProfile = Profile.fromJson(updatedLastNameResponse.data);
        Future.microtask(() {
          emit(ProfileLoaded(updatedProfile));
          lastNameController.text = updatedProfile.lastName ?? '';
        });
      } else {
        emit(ProfileError('Failed to fetch updated profile.'));
      }
    } on ServerException catch (e) {
      print('Error updating first name: $e');
      emit(ProfileError('Error updating first name: $e'));
    }
  }

  Future updateCity(
      String city, Dio dio, TextEditingController cityController) async {
    final token = CacheHelper().getData(key: ApiKey.token);
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var updatedCityResponse = await dio.put(
        'https://kemet-gp2024.onrender.com/api/v1/auth/updateProfile',
        data: {'city': city},
        options: Options(headers: {
          'token':token,
        }),
      );
      print('Response Status Code: ${updatedCityResponse.statusCode}');
      print('Response Data: ${updatedCityResponse.data}');
      print('last name: ${updatedCityResponse.data['user']['firstName']}');
      if (updatedCityResponse.statusCode == 200) {
        getUserProfile(dio);
        final updatedProfile = Profile.fromJson(updatedCityResponse.data);
        Future.microtask(() {
          emit(ProfileLoaded(updatedProfile));
          cityController.text = updatedProfile.city ?? '';
        });
      } else {
        emit(ProfileError('Failed to fetch updated profile.'));
      }
    } on ServerException catch (e) {
      print('Error updating first name: $e');
      emit(ProfileError('Error updating first name: $e'));
    }
  }

  Future updateProfile(String firstName, String lastName, String city,
      XFile image, Dio dio) async {
    try {
      MultipartFile file = await MultipartFile.fromFile(
        image.path,
        filename: path.basename(image.path),
        contentType:
            MediaType('image', path.extension(image.path).substring(1)),
      );
      FormData formData = FormData.fromMap({
        'profileImg': file,
        'firstName': firstName,
        'lastName': lastName,
        'city': city,
      });
            final token = CacheHelper().getDataString(key: ApiKey.token);

      var updatedProfileResponse = await dio.put(
        'https://kemet-gp2024.onrender.com/api/v1/auth/updateProfile',
        data: formData,
        options: Options(headers: {
          'token':token,
        }),
      );
      print('Response Status Code: ${updatedProfileResponse.statusCode}');
      print('Response Data: ${updatedProfileResponse.data}');

      if (updatedProfileResponse.statusCode == 200) {
        final updatedProfile =
            Profile.fromJson(updatedProfileResponse.data['user']);
        emit(ProfileLoaded(updatedProfile));
      } else {
        emit(ProfileError(
            'Failed to update profile. Status Code: ${updatedProfileResponse.statusCode}'));
      }
    } on ServerException catch (e) {
      print('Error updating profile: $e');
      emit(ProfileError('Error updating profile: $e'));
    } catch (e) {
      print('Unexpected error: $e');
      emit(ProfileError('Unexpected error: $e'));
    }
  }

  Future getUserPhoto(Dio dio) async {
    if (state is! ProfileLoading) {
      emit(ProfileLoading());
    }
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.get(
        'https://kemet-gp2024.onrender.com/api/v1/auth/profile',
        options: Options(headers: {
          "token":token,
        }),
      );
      //final profileImg = response.data['profileImg'];
      final profile = Profile.fromJson(response.data);

      print(profile);
      //print(profile);
      if (state is! ProfileError) {
        emit(ProfileLoaded(profile));
      }
    } on ServerException catch (e) {
      if (state is! ProfileError) {
        emit(ProfileError('Failed to fetch user profile'));
      }
    }
  }

  Future getUserNameAndPhoto(Dio dio) async {
    if (state is! ProfileLoading) {
      emit(ProfileLoading());
    }
    try {
            final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.get(
        'https://kemet-gp2024.onrender.com/api/v1/auth/profile',
        options: Options(headers: {
          "token":token,
        }),
      );
      final profile = Profile.fromJson(response.data);
      if (state is! ProfileError) {
        emit(ProfileLoaded(profile));
      }
    } on ServerException catch (e) {
      if (state is! ProfileError) {
        emit(ProfileError('Failed to fetch user profile'));
      }
    }
  }
}
