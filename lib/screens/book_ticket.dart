import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookTicket extends StatelessWidget {
  Color color = Color(0xFFe7dabb);

  BookTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            decoration: const BoxDecoration(
              color: Color(0xFFb7891b),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(700, 190),
              ),
              image: DecorationImage(
                image: AssetImage('images/Remove.png'),
                fit: BoxFit.fill,
                alignment:
                    Alignment.bottomCenter, // Align the image to the bottom
              ),
            ),
          ),
         const SizedBox(
            height: 60,
          ),
         const Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              ' Book Your Ticket ',
              style: TextStyle(
                  fontSize: 24,
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
         const SizedBox(
            height: 70,
          ),
          Padding(
            padding:const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 10,
                  decoration: BoxDecoration(
                      color:const Color(0xFFb7891b),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                ),
               const SizedBox(
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
               const SizedBox(
                    width: 13,
                    height: 10), // Adjust the spacing between points as needed
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
               const SizedBox(
                  width: 200,
                ),
                Container(
                    width: 60,
                    height: 80,
                    child: new IconButton(
                      //padding: new EdgeInsets.all(),
                      color:const Color(0xFFb7891b),
                      icon: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 70,
                      ),

                      onPressed: () {
            Navigator.pushReplacementNamed(context, '/NotificationScreen');
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
