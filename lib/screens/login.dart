import 'package:flutter/material.dart';
import 'package:kemet/pages2/privacy.dart';
import 'package:kemet/screens/loginWITHemail.dart';
import 'package:kemet/screens/signup.dart';
import 'package:kemet/widget/SignLogin.dart';
import 'package:kemet/widget/container.dart';
import 'package:kemet/widget/logo.dart';
import 'package:kemet/widget/text.dart';

class login extends StatelessWidget {
  login({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          logo(),
          const SizedBox(
            height: 49,
          ),
          Container(
            width: 228,
            height: 31,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SignLogin(
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return signup();
                      }),
                    );
                  },
                  text: "Sign up",
                ),
                SignLogin(
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return login();
                      }),
                    );
                  },
                  text: 'Login',
                  color: Color(0xffB68B25),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 266,
            child: Center(
              child: SLtext(
                text: "Welcome, Back",
                weight: FontWeight.w700,
                size: 32,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          BoxConatiner(
            text: 'Login with Email',
            size: 16,
            weight: FontWeight.w700,
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return logEmail();
              }));
            },
          ),
          const SizedBox(
            height: 160,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SLtext(
                    text: 'By signing in, i agree\t',
                    size: 12,
                    weight: FontWeight.w800,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Privacy()));
                    },
                    child: SLtext(
                      text: 'Privacy Policy\t',
                      // color: Color(0xffB68B25),
                     // color: Colors.black,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                  ),
                  // SLtext(
                  //   text: 'and',
                  //   size: 12,
                  //   weight: FontWeight.w800,
                  // )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Privacy()));
                },
                child: SLtext(
                  text: '\nMore About kemet',
                  color: Color(0xffB68B25),
                  size: 12,
                  weight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
