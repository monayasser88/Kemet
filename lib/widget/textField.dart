import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Field extends StatelessWidget {
  Field({
    this.Picon,
    this.Sicon,
    this.Ltext,
    this.Htext,
    this.height,
    this.width,
    this.radius,
    this.control
  });
  String? Ltext;
  String? Htext;
  Icon? Picon;
  Icon? Sicon;
  double? width;
  double? height;
  BorderRadius? radius;
  TextEditingController? control;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
         controller: control ,
        decoration: InputDecoration(
          labelText: Ltext,
          hintText: Htext,
          floatingLabelStyle: TextStyle(color: Color(0xffB68B25)),
          prefixIcon: Picon,
          suffixIcon: Sicon,
          border: OutlineInputBorder(
            borderRadius: radius!,
            borderSide: BorderSide(color: Color(0xff252836)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius!,
            borderSide: BorderSide(color: Color(0xffB68B25)),
          ),
        ),
       
      ),
    );
  }
}
