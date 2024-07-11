part of 'image_cubit_cubit.dart';

@immutable
sealed class ImageCubitState {}

final class ImageCubitInitial extends ImageCubitState {}
class UploadPicture extends ImageCubitState {
}