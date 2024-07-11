import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 277,
        height: 307,
        decoration: const BoxDecoration(
          color: Color(0xffB68B25),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        child: Image.asset('images/Remove.png'),
      ),
    );
  }
}
