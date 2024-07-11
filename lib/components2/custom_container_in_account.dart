import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerAccount extends StatelessWidget {
  const ContainerAccount(
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
            borderRadius: BorderRadius.circular(8),
            //color: Colors.white,
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
                    //color: Colors.black,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    contName,
                    style:const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins',
                        //color: Colors.black
                        ),
                  ),
                ],
              ),
              const Icon(
                FontAwesomeIcons.angleRight,
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
