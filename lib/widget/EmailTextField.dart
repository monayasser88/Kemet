import 'package:flutter/material.dart';

class Email_Field extends StatelessWidget {
  Email_Field({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 44,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Enter Your Email',
          prefixIcon: Icon(
            Icons.email,
            color: Color(0xffB68B25),
          ),
          floatingLabelStyle: TextStyle(color: Color(0xffB68B25)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffB68B25)),
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
