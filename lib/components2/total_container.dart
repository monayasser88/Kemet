import 'package:flutter/material.dart';
import 'package:kemet/constraints2%20(1).dart';

import '../pages2/order.dart';



// ignore: must_be_immutable
class TotalContainer extends StatelessWidget {
  const TotalContainer({super.key, required this.total});
  final String total;
  @override
  Widget build(BuildContext context) {
        return Container(
          height: 50,
          width: 345,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(children: [
                    const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryColor,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    total,
                    style: const TextStyle(fontSize: 18, fontFamily: 'poppins'),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                ]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Order();
                  }));
                },
                child: Container(
                  height: 100,
                  width: 120,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: kPrimaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'CheckOut',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins',
                          ),
                        ),
                        Icon(
                          Icons.attach_money_rounded,
                          size: 23,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
}
