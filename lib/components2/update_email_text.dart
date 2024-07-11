import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SLtext extends StatelessWidget {
    SLtext({super.key, this.text, this.size, this.color, this.weight});
  String? text;
  double? size;
  Color? color;
  FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color: color,
          fontFamily: 'Poppins',
          fontWeight: weight,
          fontSize: size,
          wordSpacing: 1),
      textAlign: TextAlign.center,
    );
  }
}