import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle(
      {super.key,
      required this.titleProfile,
      this.onTap,
      required this.userInfo});
  final String titleProfile;
  final String userInfo;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              titleProfile,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff92929D),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'poppins'),
            ),
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                  width: 18,
                  height: 18,
                  child: Icon(
                    Icons.edit,
                    color: Color(0xffB68B25),
                  )),
            )
          ],
        ),
        Text(
          userInfo,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'poppins'),
        ),
      ],
    );
  }
}
