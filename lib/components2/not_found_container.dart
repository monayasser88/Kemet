import 'package:flutter/material.dart';

class NotFoundContainer extends StatelessWidget {
  const NotFoundContainer(
      {super.key, required this.contName, required this.contIcon, this.onTap});
  final String contName;
  final IconData contIcon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 354,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    contIcon,
                    size: 24,
                    color: const Color(0xff9D9D9D),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    contName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
