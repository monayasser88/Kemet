import 'package:flutter/material.dart';
import 'package:kemet/components2/custom_text.dart';
import 'package:kemet/constraints2%20(1).dart';


class TicketContainer extends StatelessWidget {
  const TicketContainer(
      {Key? key,
      required this.title,
      required this.description,
      required this.quantity,
      required this.price,
      this.onPressed,
      this.quantityMinus,
      this.quantityPlus})
      : super(key: key);
  final String title;
  final String description;
  final String quantity;
  final String price;
  final void Function()? onPressed;
  final void Function()? quantityMinus;
  final void Function()? quantityPlus;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        elevation: 10,
        child: SizedBox(
          width: double.infinity,
          height: 180,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: kPrimaryColor, width: 5),
                    bottom: BorderSide(color: kPrimaryColor, width: 5),
                    left: BorderSide(color: Colors.grey, width: .5),
                    top: BorderSide(color: Colors.grey, width: .5),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(title: title),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              description,
                              style: const TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: quantityMinus,
                                ),
                                Text(
                                  quantity,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w800),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: quantityPlus,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.clear_rounded,
                              size: 30,
                            ),
                            onPressed: onPressed,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            price,
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
