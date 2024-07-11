// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kemet/screens/notification.dart';
import 'package:kemet/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoricScreen extends StatelessWidget {
  Color color = Color(0xFFe7dabb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: Color(0xFFb7891b),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(700, 190),
              ),
              image: DecorationImage(
                image: AssetImage('images/intro3.jpg'),
                fit: BoxFit.fill,
                alignment:
                    Alignment.bottomCenter, // Align the image to the bottom
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              ' Find Out About Historical Places',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 15,
                ), // Adjust the spacing between points as needed
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                    width: 13,
                    height: 10), // Adjust the spacing between points as needed
                Container(
                  width: 30,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Color(0xFFb7891b),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 150,
                ),
                Container(
                  width: 60,
                  height: 80,
                  child: new IconButton(
                    //padding: new EdgeInsets.all(),
                    color: Color(0xFFb7891b),
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 70,
                    ),

                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
                    },
                  ),
                ),
                Container(
                    width: 60,
                    height: 80,
                    child: new IconButton(
                      //padding: new EdgeInsets.all(),
                      color: Color(0xFFb7891b),
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 70,
                      ),

                      onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('onboardingCompleted', true);
            Navigator.pushReplacementNamed(context, '/login');
          },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
