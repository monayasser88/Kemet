import 'package:flutter/material.dart';
import 'package:kemet/screens/offers.dart';

class OfferScreen2 extends StatelessWidget {
  final TouristPlace place;

  const OfferScreen2({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    TextStyle descriptionStyle = const TextStyle(
      fontSize: 14,
      color:  Color.fromARGB(255, 113, 111, 111),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon:const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
               const Text(
                  'Best Offers',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(width: 40), // Adjust as needed
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Material(
                  elevation: 10,
                  child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      place.imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration:const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 5,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 5,
                                    ),
                                    left: BorderSide(
                                      color: Colors.grey,
                                      width: .5,
                                    ),
                                    top: BorderSide(
                                      color: Colors.grey,
                                      width: .5,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding:const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          place.title,
                                          style: titleStyle,
                                        ),
                                      ),
                                     const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        place.description,
                                        style: descriptionStyle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                     const SizedBox(height: 8),
                                      Container(
                                        height: 40, // Fixed height for price and quantity
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${place.price.toStringAsFixed(2)}', // Display price formatted as currency
                                              style:const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Qty: ${place.quantity}',
                                              style:const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
