import 'package:flutter/material.dart';
import 'package:kemet/screens/book_ticket.dart';
import 'package:kemet/screens/intro3.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Color(0xFFb7891b),elevation: 0,),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Color(0xFFb7891b),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(700, 190),
                  ),
                  image: DecorationImage(
                    image: AssetImage('images/AR.jpeg'),
                    fit: BoxFit.fill,
                    alignment:
                        Alignment.bottomCenter, // Align the image to the bottom
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  "Step into a  Kemet's world where reality meets imagination with Augmented Reality",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]),
                ),
              ), // Increase the height for additional padding
              // Text(
              //   "Step into a  Kemet's world where reality meets imagination with Augmented Reality",
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
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
                        color: Color(0xFFe7dabb),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 30,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Color(0xFFB68B25),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Color(0xFFe7dabb),
                        shape: BoxShape.circle,
                      ),
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
                              builder: (context) => BookTicket()));
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

                        onPressed: () {
            Navigator.pushReplacementNamed(context, '/HistoricScreen');
          },
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
