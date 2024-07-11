import 'package:flutter/material.dart';
import 'package:kemet/constraints2%20(1).dart';

class CustomTicket extends StatelessWidget {
  const CustomTicket({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kPrimaryColor, width: 2),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'pyramids',
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'pyramids plllllllllalalllllllllllllalalalalllll miuvhjhuygtvbmpmpmpmpmmpmmpmpmpmpmpkjhgfdsasdfghjkjhgfdfghj',
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                maxLines: 2,
              ),
            ],
          ),
        ));
  }
}
