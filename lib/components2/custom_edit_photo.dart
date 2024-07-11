import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kemet/constraints2%20(1).dart';
import 'package:kemet/cubit2/profile_cubit.dart';
class PickImageWidget extends StatelessWidget {
  PickImageWidget({Key? key}) : super(key: key);

  bool isImagePickerActive = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return SizedBox(
            width: 120,
            height: 120,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(state.profile.profilePic!),
              //: const AssetImage('assets/person.png'),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () async {
                        if (!isImagePickerActive) {
                          isImagePickerActive = true;
                          final pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedImage != null) {
                            ProfileCubit.get(context)
                                .uploadImageToApi(pickedImage);
                            isImagePickerActive = false;
                            await Future.delayed(Duration(seconds: 1));
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(
                          Icons.camera_alt_sharp,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
