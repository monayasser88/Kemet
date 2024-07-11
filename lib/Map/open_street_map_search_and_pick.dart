import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:kemet/Map/MapWidget/route.dart';
import 'package:kemet/screens/homepage.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
//import 'package:osm_search_and_pick/widgets/route.dart';
import 'package:osm_search_and_pick/widgets/wide_button.dart';

class OpenStreetMapSearchAndPick extends StatefulWidget {
  final Function(LatLng) calculateRoute; // Add the required function signature
  final void Function(PickedData pickedData) onPicked;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final IconData currentLocationIcon;
  final IconData locationPinIcon;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color locationPinIconColor;
  final String locationPinText;
  final TextStyle locationPinTextStyle;
  final String buttonText;
  final IconData buttonback;
  final String hintText;
  final double buttonHeight;
  final double buttonWidth;
  final TextStyle buttonTextStyle;
  final String baseUri;
  const OpenStreetMapSearchAndPick({
    Key? key,
    required this.onPicked,
    this.buttonback = Icons.arrow_back,
    this.zoomOutIcon = Icons.zoom_out_map,
    this.zoomInIcon = Icons.zoom_in_map,
    this.currentLocationIcon = Icons.my_location,
    this.buttonColor = Colors.grey,
    this.locationPinIconColor = Colors.red,
    this.locationPinText = '',
    this.locationPinTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
    this.hintText = 'Search Location',
    this.buttonTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
    this.buttonTextColor = Colors.white,
    this.buttonText = ' ',
    this.buttonHeight = 0,
    this.buttonWidth = 0,
    this.baseUri = 'https://nominatim.openstreetmap.org',
    this.locationPinIcon = Icons.location_on,
    required this.calculateRoute, // Initialize calculateRoute
  }) : super(key: key);
  @override
  State<OpenStreetMapSearchAndPick> createState() =>
      _OpenStreetMapSearchAndPickState();
}

class _OpenStreetMapSearchAndPickState
    extends State<OpenStreetMapSearchAndPick> {
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  int? _selectedMarkerIndex;
  final defaultPoint = LatLng(30.04402913436629, 31.23752267322945);
  LatLng? userLocation;
  List<LatLng> points = [];
  List<Marker> markers = [];
  late LatLng myPoint = defaultPoint;
  bool isLoading = false;
  bool _isSearching = false;
  final MapController mapController = MapController();
  LatLng? _selectedMarkerPosition;
  Timer? _debounce;
  var client = http.Client();
  late Future<Position?> latlongFuture;
  LatLng? _currentPosition;
  List<LatLng> _additionalMarkers = [
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
  ];
  List<String> _placeNames = [
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
  bool _showPolyline = false;
  double? _distance;
  late List<bool> _showPolylineForMarkers;
  Future<Position?> getCurrentPosLatLong() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      return await getPosition(locationPermission);
    }
    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  Future<Position?> getPosition(LocationPermission locationPermission) async {
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      return null;
    }
    Position position = await Geolocator.getCurrentPosition();
    setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  void setNameCurrentPos() async {
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;
    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  void setNameCurrentPosAtInit(double latitude, double longitude) async {
    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.get(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
  }

// Assuming you have a showConnectivityError function defined elsewhere
  void showConnectivityError(BuildContext context) {
    // Use a Snackbar or Dialog to display the message

    // Example using Snackbar:
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No internet connection. Please try again later.'),
      ),
    );

    // Example using Dialog:
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Network Error'),
        content: const Text(
            'There seems to be a problem with your internet connection. Please check your connection and try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> getCoordinates(LatLng lat1, LatLng lat2) async {
    setState(() {
      isLoading = true;
    });
    final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf6248bba97d68b8a74cc48ce76143db08c9a0',
    );
    final List<ORSCoordinate> routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate:
          ORSCoordinate(latitude: lat1.latitude, longitude: lat1.longitude),
      endCoordinate:
          ORSCoordinate(latitude: lat2.latitude, longitude: lat2.longitude),
    );
    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();
    setState(() {
      points = routePoints;
      markers = [
        Marker(
          point: lat2,
          width: 80,
          height: 80,
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      ];
      isLoading = false;
    });
  }

  void calculateRoute(LatLng start, LatLng destination) {
    if (start != null && destination != null) {
      getCoordinates(start, destination);
    } else {
      print(
          'Unable to get start or destination coordinates for route calculation');
    }
  }

  @override
  void initState() {
    super.initState();
    _showPolylineForMarkers = List.generate(
      _additionalMarkers.length,
      (index) => false,
    );
    _mapController = MapController();
    _mapController.mapEventStream.listen(
      (event) async {
        if (event is MapEventMoveEnd) {
          var client = http.Client();
          String url =
              '${widget.baseUri}/reverse?format=json&lat=${event.camera.center.latitude}&lon=${event.camera.center.longitude}&zoom=18&addressdetails=1';

          var response = await client.get(Uri.parse(url));
          var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
              as Map<dynamic, dynamic>;

          _searchController.text = decodedResponse['display_name'];
          setState(() {});
        }
      },
    );
    latlongFuture = getCurrentPosLatLong();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void togglePolyline(int index, LatLng markerPosition) {
    setState(() {
      if (_showPolylineForMarkers.length <= index) {
        // If the index is out of range, expand the list and set the new entry to false
        _showPolylineForMarkers.addAll(
            List.filled(index - _showPolylineForMarkers.length + 1, false));
      }
      _showPolylineForMarkers[index] = !_showPolylineForMarkers[index];
      if (_currentPosition != null) {
        _distance = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          markerPosition.latitude,
          markerPosition.longitude,
        );
      }
    });
  }

  void _handleMarkerSelection(LatLng markerPosition) async {
    if (userLocation != null && markerPosition != null) {
      // Calculate route to the selected marker
      await getCoordinates(userLocation!, markerPosition);

      // Update map to focus on the selected marker and display the route
      mapController.move(markerPosition, 16.5);
    } else {
      print('User location or marker position is null.');
    }
  }

  void _navigateToRouteMap(LatLng destination) {
    LatLng? userLocation = _currentPosition;
    if (userLocation != null) {
      widget.calculateRoute(destination);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
              // Pass necessary parameters to your map screen
              ),
        ),
      );
    } else {
      print('User location is not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor, width: 3.0),
    );
    return FutureBuilder<Position?>(
      future: latlongFuture,
      builder: (context, snapshot) {
        LatLng? mapCentre;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          mapCentre = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
          _currentPosition = mapCentre;
        }
        return SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: FlutterMap(
                  options: MapOptions(
                      center: mapCentre, zoom: 15.0, maxZoom: 18, minZoom: 6),
                  mapController: _mapController,
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    ),
                    MarkerLayer(
                      markers: [
                        if (_currentPosition != null)
                          Marker(
                            width: 50.0,
                            height: 50.0,
                            point: _currentPosition!,
                            child: Container(
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.green,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ..._additionalMarkers.asMap().entries.map((entry) {
                          int index = entry.key;
                          LatLng markerPosition = entry.value;
                          String placeName = _placeNames[
                              index]; // Get the corresponding place name
                          return Marker(
                            width: 50.0,
                            height:
                                70.0, // Increase height to accommodate text above
                            point: markerPosition,
                            child: GestureDetector(
                              onTap: () {
                                togglePolyline(index, markerPosition);
                                widget.calculateRoute(
                                    markerPosition); // Call calculateRoute function
                                _handleMarkerSelection(
                                    markerPosition); // Call method here
                                setState(() {
                                  _selectedMarkerIndex = index;

                                  calculateRoute(
                                      _currentPosition!, markerPosition);
                                  _selectedMarkerPosition =
                                      markerPosition; // Assign marker position to _selectedMarkerPosition
                                  print(
                                      '_selectedMarkerPosition: $_selectedMarkerPosition'); // Debug print
                                });
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: -5.0, // Position above the marker
                                    left: 0.0,
                                    right: 0.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors
                                                  .transparent, // Set the background color to transparent
                                              elevation:
                                                  0, // Optional: remove shadow
                                              content: Container(
                                                padding: EdgeInsets.all(
                                                    20), // Add padding if needed
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withOpacity(
                                                      0.7), // Adjust opacity as needed
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Optional: Add border radius
                                                ),
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      300, // Adjust the maxWidth as needed to fit the full message
                                                ),
                                                child: Text(
                                                  placeName,
                                                  style: TextStyle(
                                                    fontSize:
                                                        25.0, // Larger font size
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                    'OK',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 2.0),
                                        color: Colors.black.withOpacity(0.7),
                                        child: Text(
                                          placeName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 40.0, // Same icon size as your code
                                  ),
                                  ClipOval(
                                    child: Image.network(
                                      'https://th.bing.com/th/id/R.6046eb22e40cd305e35281a2de0be731?rik=CuW5cQh1xHDLYw&riu=http%3a%2f%2fnew3.co%2fwp-content%2fuploads%2f2018%2f01%2f1592-8.jpg&ehk=bmeC9Qy%2buLnFpBgSyKMnXtiXzQ%2ftbaMb772ERUGFTa8%3d&risl=&pid=ImgRaw&r=0',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (_selectedMarkerIndex != null &&
                                      _showPolylineForMarkers[index] &&
                                      index == _selectedMarkerIndex &&
                                      _distance != null)
                                    Positioned(
                                      bottom: 0.0, // Position at the bottom
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        color: Colors.white,
                                        child: Text(
                                          ' ${(_distance! / 1000).toStringAsFixed(2)} km',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    PolylineLayer(
                      polylines: [
                        if (_currentPosition != null)
                          ..._additionalMarkers.asMap().entries.expand((entry) {
                            int index = entry.key;
                            LatLng markerPosition = entry.value;
                            if (index < _showPolylineForMarkers.length &&
                                _showPolylineForMarkers[index] &&
                                _currentPosition != null) {
                              return [
                                Polyline(
                                  points: [
                                    _currentPosition!,
                                    markerPosition,
                                  ],
                                  strokeWidth: 4.0,
                                  color: Colors.blue,
                                ),
                              ];
                            }

                            return [];
                          }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.locationPinText,
                            style: widget.locationPinTextStyle,
                            textAlign: TextAlign.center),
                        Icon(
                          widget.locationPinIcon,
                          size: 50,
                          color: widget.locationPinIconColor,
                        ),
                        if (_distance != null && _showPolyline)
                          Text(
                            'Distance: ${(_distance! / 1000).toStringAsFixed(2)} km',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: 'btn1',
                      backgroundColor: widget.buttonColor,
                      onPressed: () {
                        _mapController.move(
                            _mapController.center, _mapController.zoom + 1);
                      },
                      child: Icon(
                        widget.zoomInIcon,
                        color: widget.buttonTextColor,
                      ),
                    ),
                    SizedBox(
                        height:
                            2), // Adjust the height between buttons as needed
                    FloatingActionButton(
                      heroTag: 'btn2',
                      backgroundColor: widget.buttonColor,
                      onPressed: () {
                        _mapController.move(
                            _mapController.center, _mapController.zoom - 1);
                      },
                      child: Icon(
                        widget.zoomOutIcon,
                        color: widget.buttonTextColor,
                      ),
                    ),
                    SizedBox(
                        height:
                            2), // Adjust the height between buttons as needed
                    FloatingActionButton(
                      heroTag: 'btn3',
                      backgroundColor: widget.buttonColor,
                      onPressed: () async {
                        if (mapCentre != null) {
                          _mapController.move(
                              LatLng(mapCentre.latitude, mapCentre.longitude),
                              _mapController.zoom);
                        } else {
                          _mapController.move(
                              const LatLng(50.5, 30.51), _mapController.zoom);
                        }
                        setNameCurrentPos();
                      },
                      child: Icon(
                        widget.currentLocationIcon,
                        color: widget.buttonTextColor,
                      ),
                    ),
                    SizedBox(
                        height:
                            2), // Adjust the height between buttons as needed
                    FloatingActionButton(
                      heroTag: 'btn4',
                      backgroundColor: widget.buttonColor,
                      onPressed: () {
                        if (_selectedMarkerIndex != null) {
                          LatLng selectedMarkerPosition =
                              _additionalMarkers[_selectedMarkerIndex!];
                          _navigateToRouteMap(selectedMarkerPosition);
                          calculateRoute(
                              _currentPosition!, selectedMarkerPosition);
                        } else {
                          // Handle the case where _selectedMarkerPosition is null, such as showing a message to the user
                          print('No marker selected');
                        }
                      },
                      child: Icon(
                        Icons
                            .directions, // Replace with the actual icon you want to use
                        color: widget.buttonTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white, // Make container transparent
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle, // Make the container circular
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              // Add IconButton for back button
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ), // Use Icons.arrow_back for back icon
                              onPressed: () {
                                // Handle back button press (navigate back, etc.)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Directionality(
                              textDirection: TextDirection
                                  .rtl, // Set the direction to right-to-left
                              child: TextFormField(
                                controller: _searchController,
                                focusNode: _focusNode,
                                textAlign: TextAlign
                                    .left, // Set text alignment to right
                                decoration: InputDecoration(
                                    hintText:
                                        'Search in Kemet Map', // Arabic hint text
                                    border: inputBorder,
                                    focusedBorder: inputFocusBorder,
                                    prefixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        // Handle search button press (optional)
                                      },
                                    ),
                                    suffixIcon: _searchController
                                            .text.isNotEmpty
                                        ? _isSearching
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 1,
                                                  height: 1,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth:
                                                        3, // You can adjust the strokeWidth if needed
                                                  ),
                                                ),
                                              )
                                            : IconButton(
                                                icon: const Icon(Icons.clear),
                                                onPressed: () {
                                                  setState(() {
                                                    _searchController.clear();
                                                  });
                                                },
                                              )
                                        : null),
                                onChanged: (String value) {
                                  if (_debounce?.isActive ?? false) {
                                    _debounce?.cancel();
                                  }
                                  _debounce = Timer(
                                    const Duration(milliseconds: 2000),
                                    () async {
                                      setState(() {
                                        _isSearching =
                                            true; // Set searching indicator to true
                                      });

                                      var client = http.Client();
                                      try {
                                        String url =
                                            '${widget.baseUri}/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';
                                        var response =
                                            await client.get(Uri.parse(url));
                                        var decodedResponse = jsonDecode(
                                                utf8.decode(response.bodyBytes))
                                            as List<dynamic>;
                                        _options = decodedResponse
                                            .map(
                                              (e) => OSMdata(
                                                displayname: e['display_name'],
                                                lat: double.parse(e['lat']),
                                                lon: double.parse(e['lon']),
                                              ),
                                            )
                                            .toList();
                                        setState(() {});
                                      } finally {
                                        setState(() {
                                          _isSearching =
                                              false; // Reset searching indicator
                                        });
                                        client.close();
                                      }
                                      setState(() {});
                                    },
                                  );
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  200, // Limit the height of the ListView
                              maxWidth: MediaQuery.of(context)
                                  .size
                                  .width, // Constrain the width
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  _options.length > 5 ? 5 : _options.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(_options[index].displayname),
                                  subtitle: Text(
                                      '${_options[index].lat},${_options[index].lon}'),
                                  onTap: () {
                                    _mapController.move(
                                      LatLng(_options[index].lat,
                                          _options[index].lon),
                                      15.0,
                                    );
                                    _focusNode.unfocus();
                                    _options.clear();
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WideButton(
                      widget.buttonText,
                      textStyle: widget.buttonTextStyle,
                      height: widget.buttonHeight,
                      width: widget.buttonWidth,
                      onPressed: () async {
                        final value = await pickData();
                        widget.onPicked(value);
                      },
                      backgroundColor: widget.buttonColor,
                      foregroundColor: widget.buttonTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        '${widget.baseUri}/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';
    var response = await client.get(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];
    return PickedData(center, displayName, decodedResponse["address"]);
  }
}

class OSMdata {
  final String displayname;
  final double lat;
  final double lon;
  OSMdata({required this.displayname, required this.lat, required this.lon});
  @override
  String toString() {
    return '$displayname, $lat, $lon';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;
  const LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String addressName;
  final Map<String, dynamic> address;
  PickedData(this.latLong, this.addressName, this.address);
}
