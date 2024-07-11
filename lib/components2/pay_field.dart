import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PayField extends StatelessWidget {
  PayField({super.key, this.text, this.ontap});
  String? text;
  Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 44,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffB68B25),
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w800,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
