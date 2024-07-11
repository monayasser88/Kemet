import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/screens/specificOffer.dart';

class TouristPlace {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final int quantity;
  final double ratingAverage;
  final List<String> images;
  final String id;
  final double priceAfterDiscount;
  TouristPlace(
      this.title,
      this.description,
      this.imageUrl,
      this.price,
      this.quantity,
      this.ratingAverage,
      this.images,
      this.id,
      this.priceAfterDiscount);
}

class offerwidget extends StatefulWidget {
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<offerwidget> {
  bool isSearching = false;
  List<TouristPlace> places = [];

  @override
  void initState() {
    super.initState();
    initializeTouristPlaces();
  }

  Future<void> initializeTouristPlaces() async {
    final dio = Dio();
    const url = 'https://kemet-gp2024.onrender.com/api/v1/offers';
          final token = CacheHelper().getDataString(key: ApiKey.token);


    try {
      final response = await dio.get(url, options: Options(
          headers: {'token': token},
        ),);
      if (response.statusCode == 200) {
        final responseData = response.data;
        final List<dynamic> offers = responseData['offers'];

        setState(() {
          places = offers.take(2).map((offer) {
            // Extract images from the offer data
            List<String> images = [];
            if (offer['images'] != null && offer['images'] is List) {
              images = List<String>.from(offer['images']);
            }

            return TouristPlace(
                offer['title'],
                offer['description'],
                offer['imgCover'],
                offer['price'].toDouble(), // Assuming price is a double
                offer['quantity'],
                offer['ratingAverage'].toDouble(),
                images,
                offer['_id'],
                offer['priceAfterDiscount'].toDouble()
                // Assuming quantity is an integer
                );
          }).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    TextStyle descriptionStyle = TextStyle(
      fontSize: 14,
      color: const Color.fromARGB(255, 113, 111, 111),
    );

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventsScreen2(
                          title: places[index].title,
                          description: places[index].description,
                          imageUrl: places[index].imageUrl,
                          price: places[index].price,
                          quantity: places[index].quantity,
                          ratingAverage: places[index].ratingAverage,
                          images: places[index].images,
                          id: places[index].id,
                          priceAfterDiscount: places[index].priceAfterDiscount,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        elevation: 10,
                        child: SizedBox(
                          width: double.infinity,
                          height: 180,
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
                                            places[index].imageUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: index.isOdd
                                                ? Colors.red
                                                : Color(0xff111441),
                                            width: 5,
                                          ),
                                          bottom: BorderSide(
                                            color: index.isOdd
                                                ? Colors.red
                                                : Color(0xff111441),
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
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                places[index].title,
                                                style: titleStyle,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                              places[index].description,
                                              style: descriptionStyle,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height:
                                                  40, // Fixed height for price and quantity
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '\$${places[index].price.toStringAsFixed(2)}', // Display price formatted as currency
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Qty: ${places[index].quantity}',
                                                    style: TextStyle(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
