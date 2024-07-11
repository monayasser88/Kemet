import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SLtext extends StatelessWidget {
  SLtext(
      {this.text,
      this.size,
      this.color,
      this.weight,
      this.overflow,
      this.decoration,this.lines});
  String? text;
  double? size;
  Color? color;
  FontWeight? weight;
  TextOverflow? overflow;
  TextDecoration? decoration;
  int? lines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: lines,
      style: TextStyle(
          color: color,
          overflow: overflow,
          fontFamily: 'Poppins',
          fontWeight: weight,
          fontSize: size,
          decoration: decoration,
          wordSpacing: 1),
      textAlign: TextAlign.center,
    );
  }
}
