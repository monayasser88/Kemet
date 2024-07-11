import 'package:flutter/material.dart';

// ignore: must_be_immutable
class imagecover extends StatelessWidget {
  imagecover(
      {this.flexvalue,
      this.width,
      this.height,
      this.radius,
      this.image,
      this.ontap,
      this.text,this.id});
  final int? flexvalue;
  Function()? ontap;
  double? width;
  double? height;
  BorderRadiusGeometry? radius;
  String? image;
  String? text; // Define text property
  String? id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: radius,
          image: DecorationImage(
            image: NetworkImage(image!),
            fit: BoxFit.fill,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            color: Colors.black54,
            child: Text(
              text!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
