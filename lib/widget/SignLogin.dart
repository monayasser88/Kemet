import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignLogin extends StatelessWidget {
  SignLogin({this.color, this.text, this.ontap});
  String? text;
  Color? color;
  Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 69,
        height: 27,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: color,
          ),
        ),
      ),
    );
  }
}
