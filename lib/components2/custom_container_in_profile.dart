import 'package:flutter/material.dart';

class ContainerProfile extends StatelessWidget {
    const ContainerProfile({super.key, required this.forwardName, this.onTap, this.color});
  final String forwardName;
  final void Function()? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 354,
        height: 45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                forwardName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'poppins',
                  //color: Colors.black
                  color: color
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                //color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
