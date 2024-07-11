import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonEmail extends StatelessWidget {
  ButtonEmail({super.key, this.text, this.ontap});
  String? text;
  Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffB68B25),
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
