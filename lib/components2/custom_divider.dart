import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.divName});
  final String divName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          divName,
          style:const TextStyle(
              fontSize: 16, color: Colors.grey,fontFamily: 'poppins', fontWeight: FontWeight.w700),
        ),
        const Flexible(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
            indent: 5,
            endIndent: 5,
          ),
        )
      ],
    );
  }
}
