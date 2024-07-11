import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(fontFamily: 'poppins', fontSize: 18),
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
          return 'You must enter a phone number.';
        }
        return null;
      },
    );
  }
}