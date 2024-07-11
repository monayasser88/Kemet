import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart'; // Import the package

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng myPoint = defaultPoint;
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> matchedPlaces = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    addDestinationMarkers();
  }

  final defaultPoint = LatLng(30.083495730284326, 31.09096288861603);
  LatLng? userLocation;
  List<LatLng> points = [];
  List<Marker> markers = [];
  bool isTextSubmitted = false; // Track whether text has been submitted

  final List<LatLng> destinationPoints = [
     LatLng(29.97762962232049, 31.132304400626012),
    LatLng(29.87128198195766, 31.216710631084474),
    LatLng(29.997404235572954, 31.214692296247282),
    LatLng(30.04605659336483, 31.224372976753475),
    LatLng(25.718911905173595, 32.657302490756884),
    LatLng(25.740568665108214, 32.602452451364925),
    LatLng(25.699588985290223, 32.63904017541596),
    LatLng(31.270350981679016, 32.30008263472384),
    LatLng(31.503708373483256, 31.830041873374974),
    LatLng(30.043419097418884, 31.247195546419544),
    LatLng(30.04792152346771, 31.26193125390447),
    LatLng(30.027860051803348, 31.213573704090997),
    LatLng(30.05652968106345, 31.219102761760507),
    LatLng(31.182539328443575, 29.89633011938594),
    LatLng(31.213955594549667, 29.885435019384555),
    LatLng(31.209871086062392, 29.90910628895727),
    LatLng(31.19479234946572, 29.904014397767625),
    LatLng(31.0460592426755, 31.379654325119137),
     LatLng(30.890868919928685, 31.45617351755011),
      LatLng(30.048530273790647, 31.233678132925522),
      LatLng(30.042582063197134, 31.22363881814319),
       LatLng(30.029080652465698, 31.229970111580275),
       LatLng(30.051069874906236, 31.261639177102335),
            LatLng(30.028858172416424, 31.249383375255544),
    // Add more destination points here
  ];

  List<String> markerNames = [
    //الجيزة
    'الاهرامات',
    'هرم زوسر',
  "القرية الفرعونية",
    'برج القاهرة',
    //الاقصر
    "معبدالكرنك",
    'معبد وادي الملوك',
    "معبد الاقصر",
    //البحر الاحمر
    
    //بورسغيد
    " متحف بورسعيد الحديث",
    // دمياط
    "راس البر",
    // القاهرة
    "قصر عابدين",
    "خان الخليلي",
    'حديقة الحيوان',
    'حديقة الاسماك',
//alex
    'عمود السواري',
    'قلعة قايتباي',
    'مكتبة الاسكندرية',
    'المسرح الروماني ',
//المنصورة
    'مسجد الموافي',
    'ثمثال ام كلثوم',
    ///////////////////////////
    'المتحف المصري',
    ' الاوبرا',
    'قصر المنيل',
    'شارع المعز',
    'مسجد احمد بن طولون',
  ];

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
        myPoint = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }
  Future<void> getCoordinates(LatLng start, LatLng end) async {
  setState(() {
    isLoading = true;
  });

  final OpenRouteService client = OpenRouteService(
    apiKey: '5b3ce3597851110001cf6248bba97d68b8a74cc48ce76143db08c9a0',
  );

  try {
    final List<ORSCoordinate> routeCoordinates = await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(latitude: start.latitude, longitude: start.longitude),
      endCoordinate: ORSCoordinate(latitude: end.latitude, longitude: end.longitude),
    );

    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    setState(() {
      points = routePoints;
      markers = [
        Marker(
          point: userLocation!,
          width: 80,
          height: 80,
          child: const Icon(
            Icons.location_on,
            color: Colors.green,
            size: 40,
          ),
        ),
        Marker(
          point: end,
          width: 80,
          height: 80,
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        ),
      ];
      isLoading = false;
    });
  } on ORSException catch (e) {
    // Handle the ORSException
    setState(() {
      isLoading = false;
    });
    print('ORSException: ${e.message}');
    // You can display an error message to the user or handle the exception in another way
  } catch (e) {
    // Handle other exceptions
    setState(() {
      isLoading = false;
    });
    print('Error: $e');
  }

}

  // Future<void> getCoordinates(LatLng lat1, LatLng lat2) async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   final OpenRouteService client = OpenRouteService(
  //     apiKey: '5b3ce3597851110001cf6248bba97d68b8a74cc48ce76143db08c9a0',
  //   );

  //   final List<ORSCoordinate> routeCoordinates = await client.directionsRouteCoordsGet(
  //     startCoordinate: ORSCoordinate(latitude: lat1.latitude, longitude: lat1.longitude),
  //     endCoordinate: ORSCoordinate(latitude: lat2.latitude, longitude: lat2.longitude),
  //   );

  //   final List<LatLng> routePoints = routeCoordinates
  //       .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
  //       .toList();
  //   setState(() {
  //     points = routePoints;
  //     markers = [
  //       Marker(
  //         point: userLocation!,
  //         width: 80,
  //         height: 80,
  //         child: const Icon(
  //           Icons.location_on,
  //           color: Colors.green,
  //           size: 40,
  //         ),
  //       ),
  //       Marker(
  //         point: lat2,
  //         width: 80,
  //         height: 80,
  //         child: const Icon(
  //           Icons.location_on,
  //           color: Colors.red,
  //           size: 40,
  //         ),
  //       ),
  //     ];
  //     isLoading = false;
  //   });
  // }

  final MapController mapController = MapController();

  void _handleMarkerSelection(LatLng markerPosition) {
    if (userLocation != null && markerPosition != null) {
      getCoordinates(userLocation!, markerPosition);
    } else {
      print('User location or marker position is null.');
    }
  }

  void _handleTap(LatLng latLng) async {
    setState(() {
      markers.clear();
      points.clear();
      markers.add(
        Marker(
          point: latLng,
          width: 80,
          height: 80,
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      );
      double zoomLevel = 5.5;
      mapController.move(latLng, zoomLevel);
    });
    if (userLocation != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isLoading = true;
        });
        getCoordinates(userLocation!, latLng); // Calculate route for selected marker only
      });
    }
  }

  void addDestinationMarkers() {
    for (int i = 0; i < destinationPoints.length; i++) {
      LatLng destination = destinationPoints[i];
      String markerName =
          markerNames.length > i ? markerNames[i] : 'Unnamed Marker $i'; // Get name from list or use a default name

      markers.add(
        Marker(
          point: destination,
          width: 80,
          height: 80,
          child: Stack(
            children: [
              Positioned(
                top: 0.0, // Adjust positioning as needed
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    markerName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0, // Adjust positioning as needed
                left: 0.0,
                right: 0.0,
                child: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void calculateRoute() async {
    if (userLocation != null && destinationPoints.isNotEmpty) {
      // Get the selected marker (assuming the first marker is selected)
      LatLng selectedMarker = destinationPoints[0]; // Modify this to access the actual selected marker

      // Call getCoordinates to calculate route for the selected marker
      await getCoordinates(userLocation!, selectedMarker);
      mapController.move(selectedMarker, 16.5); // Move map to the selected marker
    } else {
      print('Unable to get user location or destination for route calculation');
    }
  }

  void searchPlace(String placeName) {
    int index = markerNames.indexOf(placeName);
    if (index != -1) {
      LatLng searchedLocation = destinationPoints[index];
      setState(() {
        markers.clear();
        markers.add(
          Marker(
            point: searchedLocation,
            width: 80,
            height: 80,
            child: const Icon(
              Icons.location_on,
              color: Colors.blue,
              size: 40,
            ),
          ),
        );
        points.clear(); // Clear any previous route points
        mapController.move(searchedLocation, 16.5); // Move map to the searched location
      });
    } else {
      print('Place not found');
    }
  }

  void updateMatchedPlaces(String query) {
    setState(() {
      matchedPlaces = markerNames
          .where((place) => place.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              zoom: 5,
              center: myPoint,
              onTap: (tapPosition, latLng) => _handleTap(latLng),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: markers,
              ),
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.black,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: isTextSubmitted ? BorderRadius.circular(20) : BorderRadius.circular(0), // Circular border when text submitted
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for a place',
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                            contentPadding: EdgeInsets.zero, // Remove any internal padding
                          ),
                          onSubmitted: (value) {
                            searchPlace(value);
                            setState(() {
                              isTextSubmitted = true; // Text submitted, change appearance
                            });
                          },
                          onChanged: (value) {
                            updateMatchedPlaces(value); // Update matched places on text change
                            setState(() {
                              isTextSubmitted = value.isNotEmpty; // Show clear icon when text is entered
                            });
                          },
                        ),
                      ),
                      if (isTextSubmitted) // Show clear icon only when text is submitted
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              matchedPlaces.clear();
                              isTextSubmitted = false; // Clear text, change appearance
                            });
                          },
                        ),
                    ],
                  ),
                ),
                if (matchedPlaces.isNotEmpty) // Show matched places list if there are matches
                  Container(
                    height: 200, // Set a fixed height for the list
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: matchedPlaces.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(matchedPlaces[index]),
                          onTap: () {
                            searchPlace(matchedPlaces[index]);
                            setState(() {
                              matchedPlaces.clear();
                              _searchController.clear();
                              isTextSubmitted = false; // Clear text and matched places on selection
                            });
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomOut', // Unique tag for the zoom out button
            backgroundColor: Colors.grey,
            onPressed: () {
              // Update the map zoom level to zoom out
              mapController.move(myPoint, mapController.zoom - 1.5); // Adjust zoom value as needed
            },
            child: const Icon(
              Icons.zoom_out_map, // Change icon to zoom_out
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2), // Add spacing between buttons
          FloatingActionButton(
            heroTag: 'zoomIn', // Unique tag for the zoom in button
            backgroundColor: Colors.grey,
            onPressed: () {
              // Update the map zoom level to zoom in
              mapController.move(myPoint, mapController.zoom + 1); // Adjust zoom value as needed
            },
            child: const Icon(
              Icons.zoom_in_map, // Icon for zoom in
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2),
          FloatingActionButton(
            heroTag: 'backButton', // Unique tag for the back button
            backgroundColor: Colors.grey,
            onPressed: () {
              // Navigate back to the previous screen
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}