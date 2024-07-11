import 'package:image_picker/image_picker.dart';

abstract class createprofilestate {}

final class createprofileSuccess extends createprofilestate {
  final String msg;
  createprofileSuccess({required this.msg});
   
 
  //createprofileSuccess(this.profile);
}
final class UploadProfilePic extends createprofilestate {}

final class uploadpicture extends createprofilestate{
 final XFile? profilePic;

   uploadpicture({required this.profilePic});
}
final class createprofileInitial extends createprofilestate {}

class createprofileLoading extends createprofilestate {}

class createprofileError extends createprofilestate {
  final String error;

  createprofileError({required this.error});
}
