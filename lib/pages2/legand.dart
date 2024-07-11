import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Legend extends StatefulWidget {
  final Map<String, dynamic> legend;

  Legend({required this.legend});

  @override
  _LegendState createState() => _LegendState();
}

class _LegendState extends State<Legend> {
  bool _isPressed = false;
  final String baseUrl = 'https://kemet-gp2024.onrender.com/api/v1';
@override
  void initState() {
    super.initState();
  
        _loadFavoriteStatus();

  }
  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPressed = prefs.getBool('favorite_${widget.legend}') ?? false;
    });
  }

  void _saveFavoriteStatus(bool isPressed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('favorite_${widget.legend}', isPressed);
  }


  Future<void> addToWishlist(String legendId, String token) async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.patch(
        '$baseUrl/legendWL/addToWishList',
        data: {'document': legendId},
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 200) {
        print('Legend added to wishlist successfully');
      } else {
        throw Exception('Failed to add legend to wishlist');
      }
    } catch (e) {
      print('Error adding legend to wishlist: $e');
      throw Exception('Failed to add legend to wishlist');
    }
  }

  Future<void> _removeFromWishlist(String legendId, String token) async {
    final String apiUrl =
        'https://kemet-gp2024.onrender.com/api/v1/legendWL/removeFromWishList/$legendId';

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
        print('Legend with ID $legendId removed from wishlist successfully.');
        // Optionally, handle state update or UI changes after successful removal
      } else {
        throw Exception(
            'Failed to remove legend from wishlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error removing legend from wishlist: $e');
      // Handle error, show user feedback, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back button
        //backgroundColor: const Color.fromARGB(255, 235, 231, 231),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20),
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
                  addToWishlist(
                    widget.legend['_id'],token!
                    // Replace 'your_token_here' with your actual token
                  );
                } else {
                   _removeFromWishlist(
                    widget.legend['_id'],token!
                    // Replace 'your_token_here' with your actual token
                  );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.legend['images'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.legend['images'][index],
                            width: 200,
                            height: 160,
                            fit: BoxFit.cover,
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
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                widget.legend['name'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Description',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 15),
              child: Text(
                widget.legend['informationAbout'],
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
