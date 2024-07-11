import 'package:flutter/material.dart';

// ignore: must_be_immutable
class divider extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  divider({this.in_end_dent,this.height});
  double? in_end_dent;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        height: height,
        thickness: 1,
        color: Color(0xff92929D),
        indent: in_end_dent,
        endIndent: in_end_dent,
      ),
    );
  }
}
