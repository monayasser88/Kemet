import 'package:flutter/material.dart';
import 'package:kemet/screens/email_forgetpass.dart';
import 'package:kemet/screens/loginWITHemail.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/container.dart';
import 'package:kemet/widget/text.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
           
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
             const SizedBox(height: 195),
              SLtext(
                text: 'Forget Password',
                
                size: 32,
                weight: FontWeight.w700,
              ),
             const SizedBox(height: 20),
              SLtext(
                text: "Please choose a recovery method",
                color:const Color(0xff92929D),
                size: 16,
                weight: FontWeight.w500,
              ),
             const SizedBox(height: 20),
              BoxConatiner(
                text: "Email",
               
                size: 16,
                weight: FontWeight.w700,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Email_ForgetPass();
                    }),
                  );
                },
              ),
            const  SizedBox(height: 270),
              button(
                text: 'Login',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const logEmail();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
