import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/models2/favorites_tourism.dart';
import 'package:kemet/screens/listofTrps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryOfPlace extends StatefulWidget {
  final TourismPlace tourismPlace;

  HistoryOfPlace({required this.tourismPlace});

  @override
  _HistoryOfPlaceState createState() => _HistoryOfPlaceState();
}

class _HistoryOfPlaceState extends State<HistoryOfPlace> {
  bool _isPressed = false;

  final String baseUrl = 'https://kemet-gp2024.onrender.com/api/v1';

  Future<void> addToWishlist(String tourismId, String token) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.patch(
        '$baseUrl/tourismPlaceWL/addToWishList',
        data: {'document': tourismId},
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 200) {
        print('TourismPlace added to wishlist successfully');
      } else {
        throw Exception('Failed to add trip to wishlist');
      }
    } catch (e) {
      print('Error adding trip to wishlist: $e');
      throw Exception('Failed to add TourismPlace to wishlist');
    }
  }

  Future<void> _removeFromWishlist(String tourismId, String token) async {
    final String apiUrl =
        'https://kemet-gp2024.onrender.com/api/v1/tourismPlaceWL/removeFromWishList/$tourismId';

    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.delete(
        apiUrl,
        options: Options(
          headers: {'token': token},
        ),
      );

      if (response.statusCode == 200) {
        print(
            'TourismPlace with ID $tourismId removed from wishlist successfully.');
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

  @override
  void initState() {
    super.initState();

    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPressed = prefs.getBool('favorite_${widget.tourismPlace.id}') ?? false;
    });
  }

  void _saveFavoriteStatus(bool isPressed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('favorite_${widget.tourismPlace.id}', isPressed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back button
        // backgroundColor: const Color.fromARGB(255, 235, 231, 231),
        // Set the background color to white
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20), // Adjust padding
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

                if (_isPressed) {
                  final token = CacheHelper().getDataString(key: ApiKey.token);

                  addToWishlist(
                    widget.tourismPlace.id,
                    token!,
                  ); // Replace 'your_token_here' with your actual token
                } else {
                  final token = CacheHelper().getDataString(key: ApiKey.token);

                  _removeFromWishlist(
                    widget.tourismPlace.id,
                    token!,
                  ); // Replace 'your_token_here' with your actual token
                }
              },
            ),
          ),
        ],
        title: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            // color: Colors.black,
          ),
          iconSize: 30,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: 211.0, // Set a fixed height for the container
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tourismPlace.images.length,
                      itemBuilder: (context, index) {
                        String imageUrl = widget.tourismPlace.images[index];
                        return Padding(
                          padding: EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Material(
                              elevation: 10,
                              child: SizedBox(
                                width:
                                    400, // Set the width of each image container
                                height:
                                    211.0, // Set the height of each image container
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageUrl),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5),
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.arrow_back_ios_new_rounded,
                  //       color: Colors.white,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //   ),
                  // ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        widget.tourismPlace.name,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 13),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  widget.tourismPlace.informationAbout,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 7.0, left: 100, right: 100),
                child: ElevatedButton(
                  onPressed: () {
                    // Create a Trip object based on the TouristPlace details
                    // Navigate to MyTripOfPlace screen with the created Trip object

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TripsScreen()),
                    );
                  },
                  child: Text(
                    'Your Trips',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 180, 17, 0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
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
