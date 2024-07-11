import 'package:flutter/material.dart';

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            //color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 85,
        ),
        Text(
          title,
          style: const TextStyle(
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
