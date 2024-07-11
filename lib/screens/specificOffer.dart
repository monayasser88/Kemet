import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';

class EventsScreen2 extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final int quantity;
  final double ratingAverage;
  final List<String> images;
  final String id;
  final double priceAfterDiscount;
  const EventsScreen2(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.quantity,
      required this.ratingAverage,
      required this.images,
      required this.id,
      required this.priceAfterDiscount});

  @override
  State<EventsScreen2> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen2> {
  final List<Map<String, dynamic>> reviews = [];
  bool _ticketBooked = false;

  final String abaseUrl = 'https://kemet-gp2024.onrender.com/api/v1';
  Future<void> addTicket(String tripId, String token) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.post(
        '$abaseUrl/MyTickets',
        data: {'trip': tripId},
        options: Options(headers: {
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        print('Ticket added successfully');
      } else {
        print('Failed to add ticket. Status code: ${response.statusCode}');
        throw Exception('Failed to add ticket');
      }
    } catch (e) {
      print('Error adding ticket: $e');
      throw Exception('Failed to add ticket');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Container(
                height: constraints.maxHeight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 211.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.images.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      widget.images[
                                          index], // Use the image URL from the list
                                      width: 200,
                                      height: 211.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3, top: 20),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              widget.title, // Display the event title
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RatingBar.builder(
                            initialRating: widget.ratingAverage,
                            itemCount: 5,
                            itemSize: 25,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            ignoreGestures: true,
                            onRatingUpdate: (double value) {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 1),
                        child: Text(
                          widget.description, // Display the event description
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 11),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        'Price:', // New price with 'Price' prefix
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' \$${widget.priceAfterDiscount.toStringAsFixed(2)}', // New price with 'Price' prefix
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' \$${widget.price.toStringAsFixed(2)}', // Old price with space for separation
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.red,
                                      fontSize: 13,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: ElevatedButton.icon(
                                onPressed: _ticketBooked
                                    ? null
                                    : () {
                                        final token = CacheHelper()
                                            .getDataString(key: ApiKey.token);

                                        // Call addTicket function when button is pressed
                                        addTicket(widget.id, token!).then((_) {
                                          setState(() {
                                            _ticketBooked = true;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Success! Your Ticket is booked',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        }).catchError((error) {
                                          print('Error booking ticket: $error');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Failed to book ticket',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                icon: _ticketBooked
                                    ? Icon(Icons.check, color: Colors.white)
                                    : Icon(Icons.add, color: Colors.white),
                                label: Text(
                                  'My Tickets',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white),
                                  overflow: TextOverflow
                                      .ellipsis, // Ensure text stays in one line
                                  maxLines: 1, // Limit to one line
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _ticketBooked
                                      ? Color.fromARGB(255, 210, 204, 204)
                                      : Color.fromRGBO(255, 180, 17, 0.7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Row(
                          children: [
                            Text(
                              'Quantity : ', // Display quantity in stock
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                // color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.quantity.toString(), // Display quantity
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
