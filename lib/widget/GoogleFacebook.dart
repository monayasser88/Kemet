import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GFcontainer extends StatelessWidget {
  GFcontainer({this.image});
  String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 57,
      decoration: BoxDecoration(
        border: Border.all(
       
          width: 2,
          //width of border
        ),
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: AssetImage(image!),
        ),
      ),
    );
  }
}
