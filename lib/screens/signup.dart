import 'package:flutter/material.dart';
import 'package:kemet/pages2/privacy.dart';
import 'package:kemet/screens/login.dart';
import 'package:kemet/screens/signWITHemail.dart';
import 'package:kemet/widget/SignLogin.dart';
import 'package:kemet/widget/container.dart';
import 'package:kemet/widget/logo.dart';
import 'package:kemet/widget/text.dart';

class signup extends StatelessWidget {
  signup({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    color: Color(0xffB68B25),
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
                  text: "Welcome",
                  weight: FontWeight.w700,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            BoxConatiner(
              text: "Sign Up with Email",
              size: 16,
              weight: FontWeight.w700,
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return signEmail();
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
                        //color: Colors.black,
                        //color: Color(0xffB68B25),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Privacy()));
                  },
                  child: SLtext(
                    text: '\n More About Kemet',
                    color: Color(0xffB68B25),
                    size: 12,
                    weight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
