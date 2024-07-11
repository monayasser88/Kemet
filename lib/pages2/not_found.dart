import 'package:flutter/material.dart';
import 'package:kemet/components2/not_found_container.dart';
import 'package:kemet/constraints2%20(1).dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  NotFoundContainer(
                    contIcon: Icons.search,
                    contName: 'here',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'No Results',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '0 found',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    'images/notfound.png',
                    width: 270,
                    height: 270,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Not Found',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    '   Sorry, the keyword you entered cannot',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  const Text(
                    '   be found, please check again or',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  const Text(
                    '    search with another keyword.',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
