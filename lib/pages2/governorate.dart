import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/models2/favorites_tourism.dart';
import 'package:kemet/pages2/history_of_place.dart';
import 'package:kemet/pages2/tourism_search.dart';

class ToristPlace extends StatefulWidget {
  final String governateId;

  ToristPlace({required this.governateId});

  @override
  _ToristPlaceState createState() => _ToristPlaceState();
}

class _ToristPlaceState extends State<ToristPlace> {
  List<TourismPlace> places = [];

  @override
  void initState() {
    super.initState();
    initializeTouristPlaces(widget.governateId);
  }

  void initializeTouristPlaces(String governrateId) async {
    final String apiUrl =
        'https://kemet-gp2024.onrender.com/api/v1/governrates/$governrateId/tourismPlaces';

    try {
      Dio dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      Response response = await dio.get(apiUrl, options: Options(
          headers: {'token': token},
        ),);

      if (response.statusCode == 200) {
        final List<dynamic> documents = response.data['document'];
        List<TourismPlace> fetchedPlaces = documents.map((data) {
          return TourismPlace.fromJson(data);
        }).toList();

        setState(() {
          places = fetchedPlaces;
        });
      } else {
        throw Exception('Failed to load tourist places');
      }
    } catch (error) {
      print('Error fetching tourist places: $error');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 40.0, right: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Tourism Places',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 35.0),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TourismSearch()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: 355,
                    height: 38,
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(Icons.search),
                        SizedBox(width: 15),
                        Text(
                          'Search',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey), // Add border
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryOfPlace(
                            tourismPlace: places[index],
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
                                              places[index].imgCover,
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
                                              color: index % 2 == 0
                                                  ? Colors.red
                                                  : Color(0xff111441),
                                              width: 5,
                                            ),
                                            bottom: BorderSide(
                                              color: index % 2 == 0
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
                                              Text(
                                                places[index].name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                places[index].informationAbout,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
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
          ),
        ],
      ),
    );
  }
}
