import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kemet/cubit/createprofile_cubit.dart';
import 'package:kemet/cubit/createprofile_state.dart';



class PickImageWidget extends StatefulWidget {
  const PickImageWidget({Key? key}) : super(key: key);

  @override
  _PickImageWidgetState createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  late createprofileCubit createprofile;

  @override
  void initState() {
    super.initState();
    createprofile = context.read<createprofileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<createprofileCubit, createprofilestate>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SizedBox(
          width: 120,
          height: 120,
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            backgroundImage: _getImageProvider(),
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () async {
                      final pickedImage = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedImage != null) {
                        createprofile.uploadProfilePic(pickedImage);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                              color: Color(0xffB68B25),
                        border: Border.all(                              color: Color(0xffB68B25),
 width: 3),
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
      },
    );
  }

  ImageProvider<Object>? _getImageProvider() {
    if (createprofile.profilePic == null) {
      return const AssetImage("images/person.png");
    } else {
      return FileImage(File(createprofile.profilePic!.path));
    }
  }
}
