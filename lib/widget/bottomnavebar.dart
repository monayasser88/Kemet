import 'package:flutter/material.dart';

// ignore: must_be_immutable
class bottom extends StatelessWidget {
  bottom({this.image, this.ontap, this.text, this.color});
  String? image;
  Function()? ontap;
  String? text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Column(children: [
          Image.asset(
            image!,
            width: 74,
            height: 45,
          ),
          // Text(
          //   text!,
          //   style: TextStyle(
          //       color: color,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //       wordSpacing: 1),
          //   textAlign: TextAlign.center,
          // ),
        ]));
  }
}
