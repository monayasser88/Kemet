import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BoxConatiner extends StatelessWidget {
  BoxConatiner({this.text, this.size, this.color, this.weight,this.ontap});

  String? text;
  double? size;
  Color? color;
  FontWeight? weight;
  Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 44,
        width: 353,
        decoration: BoxDecoration(
          border: Border.all(//color of border
            width: 2,
            //width of border
           color: Colors.grey
            
          ),
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text!,
              style: TextStyle(
                  color: color,
                  fontFamily: 'Poppins',
                  fontWeight: weight,
                  fontSize: size,
                  wordSpacing: 1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
