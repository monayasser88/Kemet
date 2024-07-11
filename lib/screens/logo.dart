import 'package:flutter/material.dart';
import 'package:kemet/screens/book_ticket.dart';
import 'package:kemet/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logo extends StatefulWidget {
  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 5), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => BookTicket()));
    // }
    // );
    _checkOnboardingStatus();
    // TODO: implement initState
    super.initState();
  }

  _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isOnboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Future.delayed(Duration(seconds: 6), () {
     if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (isOnboardingCompleted) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/BookTicket');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
    //  decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height:350,
            width: 350,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                  "images/cropPhoto.png",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: Color.fromARGB(255, 148, 110, 22),
            ),
          )
        ],
      ),
    ));
  }
}
