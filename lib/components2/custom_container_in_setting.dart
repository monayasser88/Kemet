import 'package:flutter/material.dart';

class CustomContainerSetting extends StatelessWidget {
  const CustomContainerSetting(
      {super.key, required this.tileName, required this.icon});
  final String tileName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 354,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  //color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  tileName,
                  style:const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'poppins',
                      //color: Colors.black
                      ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              //color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
