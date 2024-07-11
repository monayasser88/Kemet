import 'package:flutter/material.dart';
import 'package:kemet/cubit2/profile_cubit.dart';

class CustomAppBarProfile extends StatelessWidget {
  const CustomAppBarProfile({super.key, required this.title, this.onTap, required this.profileCubit});
  final String title;
  final void Function()? onTap;
  final ProfileCubit profileCubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child:const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            //color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 125,
        ),
        Text(
          title,
          style:const TextStyle(
              fontSize: 20,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w900,
              //color: Colors.black
              ),
        ),
      ],
    );
  }
}
