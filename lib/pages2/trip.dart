import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/models2/favorites_trip.dart';
import 'package:kemet/models2/user_model.dart';
import 'review.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyTripOfPlace extends StatefulWidget {
  final Trips trip;
  MyTripOfPlace({required this.trip});

  @override
  _MyTripOfPlaceState createState() => _MyTripOfPlaceState();
}

class _MyTripOfPlaceState extends State<MyTripOfPlace> {
  bool _isPressed = false;
  bool _ticketBooked = false;
  List<dynamic> reviews = [];
  TextEditingController _reviewController = TextEditingController();
  double _userRating = 0;
  

  Future<void> _fetchReviews(String tripId) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.get(
        'https://kemet-gp2024.onrender.com/api/v1/trips/$tripId',
        options: Options(
          headers: {'token': token},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['document'];

        // Check if 'myReviews' is present and not null
        if (data != null && data['myReviews'] != null) {
          setState(() {
            reviews = data['myReviews'];
          });
        } else {
          setState(() {
            reviews = []; // Ensure reviews is an empty list if there's no data
          });
          print('No reviews found in the response');
        }
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      print('Error fetching reviews: $e');
      throw Exception('Failed to load reviews');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchReviews(widget.trip.id);
        _loadFavoriteStatus();

  }
  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPressed = prefs.getBool('favorite_${widget.trip.id}') ?? false;
    });
  }

  void _saveFavoriteStatus(bool isPressed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('favorite_${widget.trip.id}', isPressed);
  }


  bool _hasReviewed = false; // Track if a review has been submitted

  void _submitReview() async {
    if (_hasReviewed) {
      // If already reviewed, do nothing
      return;
    }

    String reviewText = _reviewController.text.trim();
    if (reviewText.isNotEmpty && _userRating > 0) {
      try {
        final dio = Dio();
        final token = CacheHelper().getDataString(key: ApiKey.token);

        final response = await dio.post(
          'https://kemet-gp2024.onrender.com/api/v1/reviews/${widget.trip.id}',
          data: {'text': reviewText, 'rate': _userRating},
          options: Options(headers: {
            'token': token,
          }),
        );
        if (response.statusCode == 200) {
          setState(() {
            _hasReviewed = true; // Mark as reviewed
            _reviewController.clear();
            _userRating = 0;
          });
          _fetchReviews(widget.trip.id); // Refresh reviews after submitting
        } else {
          throw Exception('Failed to submit review');
        }
      } catch (e) {
        print('Error submitting review: $e');
        // Handle error if submission fails
      }
    }
  }

  final String baseUrl = 'https://kemet-gp2024.onrender.com/api/v1';

  Future<void> addToWishlist(String tripId, String token) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      // Set the authorization token in the headers
      final response = await dio.patch(
        '$baseUrl/tripWL/addToWishList',
        data: {'document': tripId},
        options: Options(headers: {
          'token': token,
        }),
      );
      if (response.statusCode == 200) {
        print('Trip added to wishlist successfully');
      } else {
        throw Exception('Failed to add trip to wishlist');
      }
    } catch (e) {
      print('Error adding trip to wishlist: $e');
      throw Exception('Failed to add trip to wishlist');
    }
  }

  void _removeFromWishlist(String tripId) async {
    final String apiUrl =
        'https://kemet-gp2024.onrender.com/api/v1/tripWL/removeFromWishList/$tripId';

    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.delete(
        apiUrl,
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Trip with ID $tripId removed from wishlist successfully.');
        // Optionally, handle state update or UI changes after successful removal
      } else {
        throw Exception(
            'Failed to remove trip from wishlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error removing trip from wishlist: $e');
      // Handle error, show user feedback, etc.
    }
  }

  Future<void> _deleteReview(String reviewId) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.delete(
        'https://kemet-gp2024.onrender.com/api/v1/reviews/$reviewId',
        options: Options(headers: {
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _hasReviewed = false; // Reset to allow submitting a new review
        });
        _fetchReviews(widget.trip.id); // Refresh reviews after deleting
        print('Review deleted successfully');
      } else {
        throw Exception('Failed to delete review');
      }
    } catch (e) {
      print('Error deleting review: $e');
      // Handle error if deletion fails
    }
  }

  Future<void> updateReview(
      String reviewId, String text, double rating, String token) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.put(
        'https://kemet-gp2024.onrender.com/api/v1/reviews/$reviewId',
        data: {
          'text': text,
          'rate': rating,
        },
        options: Options(headers: {
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        print('Review updated successfully');
        int reviewIndex =
            reviews.indexWhere((review) => review['_id'] == reviewId);
        reviews[reviewIndex]['text'] = text;
        reviews[reviewIndex]['rate'] = rating;
        setState(() {
          _fetchReviews(widget.trip.id);
        });
      } else {
        throw Exception('Failed to update review');
      }
    } catch (e) {
      print('Error updating review: $e');
      throw Exception('Failed to update review');
    }
  }

  final String abaseUrl = 'https://kemet-gp2024.onrender.com/api/v1';

  Future<void> addTicket(String tripId, String token) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.post(
        '$baseUrl/MyTickets',
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back button
        // backgroundColor: const Color.fromARGB(
        //     255, 235, 231, 231), // Set the background color to white
        actions: [
          Padding(
            padding:
                EdgeInsets.only(top: 10, right: 20), // Adjust padding as needed
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: _isPressed ? Colors.red : Colors.grey,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _isPressed = !_isPressed;
                });
                _saveFavoriteStatus(_isPressed);
                final token = CacheHelper().getDataString(key: ApiKey.token);

                if (_isPressed) {
                  // Call the addToWishlist function to add the trip to the wishlist
                  addToWishlist(widget.trip.id, token!);
                } else {
                  // Call the _removeFromWishlist function to remove the trip from the wishlist
                  _removeFromWishlist(widget.trip.id);
                }
              },
            ),
          ),
        ],
        title: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            //color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: 211.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.trip.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.trip.images[index],
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
                    children: [],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.trip.name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: widget.trip.ratingAverage,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 25,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          _userRating = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  widget.trip.informationAbout,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Text(
                      'Price: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${widget.trip.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    if (widget.trip.isOffered)
                      Text(
                        ' Offered',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Text(
                      'Quantity: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        //  color: Colors.black,
                      ),
                    ),
                    Text(
                      '${widget.trip.quantity}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 70),
                        child: ElevatedButton.icon(
                          onPressed: _ticketBooked
                              ? null
                              : () {
                                  final token = CacheHelper()
                                      .getDataString(key: ApiKey.token);

                                  // Call addTicket function when button is pressed
                                  addTicket(widget.trip.id, token!).then((_) {
                                    setState(() {
                                      _ticketBooked = true;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Success! Your Ticket is booked',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    );
                                  }).catchError((error) {
                                    print('Error booking ticket: $error');
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                              color: Colors.white,
                            ),
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
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: RatingBar.builder(
                    initialRating: _userRating,
                    itemCount: 5,
                    itemSize: 25,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        _userRating = rating;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _reviewController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Write a review...',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffB68B25),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 100.0, vertical: 9.0),
                child: ElevatedButton(
                  onPressed: _hasReviewed
                      ? null // Disable button if review has been submitted
                      : _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 180, 17, 0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: Text(
                    _hasReviewed ? 'Already submitted' : 'Submit',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 20, right: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      reviews.length,
                      (index) => ReviewItem(
                        review: reviews[index],
                        onDelete: () {
                          setState(() {
                            String reviewId = reviews[index]['_id'];
                            _deleteReview(reviewId);
                          });
                        },
                        // Inside the AlertDialog section of your UI (e.g., within a widget function)
                        onUpdate: (String initialText, double initialRating) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              double updatedRating = initialRating;
                              TextEditingController textEditingController =
                                  TextEditingController(text: initialText);

                              return AlertDialog(
                                title: Text(
                                  'Update Review',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: initialRating,
                                      itemCount: 5,
                                      itemSize: 25,
                                      itemBuilder: (context, index) {
                                        return Icon(
                                          Icons.star,
                                          color: updatedRating >= index + 1
                                              ? Colors.amber
                                              : Colors
                                                  .grey, // Update star color based on the updatedRating
                                        );
                                      },
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          initialRating =
                                              rating; // Update initialRating
                                          updatedRating =
                                              rating; // Update updatedRating in setState
                                          print('Updated rating: $rating');
                                        });
                                      },
                                    ),
                                    TextField(
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        hintText: 'Update a review...',
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Color(0xffB68B25),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Color(0xffB68B25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB68B25),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      String updatedReviewText =
                                          textEditingController.text;
                                      if (updatedReviewText.isNotEmpty) {
                                        String reviewId = reviews[index][
                                            '_id']; // Assuming `index` is accessible in this context
                                        try {
                                          final token = CacheHelper()
                                              .getDataString(key: ApiKey.token);

                                          await updateReview(
                                              reviewId,
                                              updatedReviewText,
                                              updatedRating,
                                              token!);
                                          // Update local state with the updated review
                                          setState(() {
                                            // Find the index of the review in the reviews list
                                            int reviewIndex =
                                                reviews.indexWhere((review) =>
                                                    review['_id'] == reviewId);
                                            // Update the text and rating of the review
                                            reviews[reviewIndex]['text'] =
                                                updatedReviewText;
                                            reviews[reviewIndex]['rate'] =
                                                updatedRating;
                                          });
                                          print('Review updated successfully');
                                          Navigator.of(context)
                                              .pop(); // Close dialog after update
                                        } catch (error) {
                                          print(
                                              'Error updating review: $error');
                                          // Handle error, e.g., show error message
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB68B25),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
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
