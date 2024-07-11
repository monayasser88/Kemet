import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
part 'image_cubit_state.dart';

class ImageCubitCubit extends Cubit<ImageCubitState> {

  ImageCubitCubit() : super(ImageCubitInitial());
XFile? profilePic;
updateProfilePic(XFile image) {
    profilePic = image;
    emit(UploadPicture());
  }
}
