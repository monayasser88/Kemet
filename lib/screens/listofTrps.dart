import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/models2/favorites_trip.dart';
import 'package:kemet/models2/trip_model.dart';
import 'package:kemet/pages2/trip.dart';

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final String apiUrl = 'https://kemet-gp2024.onrender.com/api/v1/trips';
  List<Trips> trips = [];
  bool isLoading = true;
  bool isError = false;
  Dio dio = Dio();
        final token = CacheHelper().getDataString(key: ApiKey.token);

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    try {
      Response response = await dio.get(apiUrl, options: Options(
          headers: {'token': token},
        ),);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['document'];
        List<Trips> loadedTrips = data.map((tripData) {
          return Trips(
            id: tripData['_id'],
            name: tripData['title'],
            informationAbout: tripData['description'],
            imgCover: tripData['imgCover'],
            price: (tripData['price'] ?? 0.0).toDouble(),
            quantity: tripData['quantity'] ?? 0,
            isOffered: tripData['isOffered'],
            images: tripData['images'] != null
                ? List<String>.from(tripData['images'])
                : [],
            reviews: [],
            ratingAverage: tripData['ratingAverage'] != null
                ? tripData['ratingAverage'].toDouble()
                : 0,
          );
        }).toList();
        setState(() {
          trips = loadedTrips;
          isLoading = false;
          isError = false;
        });
      } else {
        throw Exception('Failed to load trips: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trips: $e');
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  void _navigateToMyTrip(BuildContext context, Trips trip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyTripOfPlace(trip: trip),
      ),
    );
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
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    // color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Center(
                  // Center the title horizontally
                  child: Text(
                    'Trips',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      // color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 50), // Adjust spacing between icon and title
              ],
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : isError
                      ? Center(
                          child:
                              Text('Failed to load trips. Please try again.'))
                      : ListView.builder(
                          itemCount: trips.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _navigateToMyTrip(context,
                                    trips[index]); // Navigate to selected trip
                              },
                              child: Padding(
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
                                                        trips[index].imgCover,
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
                                                            : Colors.black,
                                                        width: 5,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: index.isOdd
                                                            ? Colors.red
                                                            : Colors.black,
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
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          trips[index].name,
                                                          style: titleStyle,
                                                        ),

                                                        SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            trips[index]
                                                                .informationAbout,
                                                            style:
                                                                descriptionStyle,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 8,
                                                        ), // Fill remaining space
                                                        Container(
                                                          height:
                                                              40, // Fixed height for price and quantity
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '\$${trips[index].price.toStringAsFixed(2)}', // Display price formatted as currency
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Qty: ${trips[index].quantity}',
                                                                style:
                                                                    TextStyle(
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
      ),
    );
  }
}
