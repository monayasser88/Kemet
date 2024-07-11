import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
    const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 354,
      height: 44,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Enter Your Email',
          floatingLabelStyle:const TextStyle(color: Color(0xffB68B25)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(color: Color(0xff252836)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(color: Color(0xffB68B25)),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter an email';
          } else if (!value.contains('@') || !value.contains('.')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }
}