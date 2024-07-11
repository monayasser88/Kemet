import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.suffixIcon});
  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(fontFamily: 'poppins', fontSize: 18),
        ),
        hintText: hint,
        floatingLabelStyle: const TextStyle(color: Color(0xffB68B25)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xff252836)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffB68B25)),
        ),
        suffixIcon: suffixIcon,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'you must enter this information';
        } else if (RegExp(r'[!@#$%^&*(),.?":{}|<>_+=]').hasMatch(value)) {
          return 'This field cannot contain symbols';
        }
      },
    );
  }
}