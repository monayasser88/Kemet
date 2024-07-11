import 'package:dio/dio.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/pages2/account.dart';
import 'package:kemet/pages2/legand.dart';
import 'package:kemet/pages2/legand_search.dart';
import 'package:kemet/screens/homepage.dart';
import 'package:kemet/widget/bottomnavebar.dart';
import 'package:kemet/Map/open_street_map_search_and_pick.dart';


class LegendCategory extends StatefulWidget {
  @override
  _LegendCategoryState createState() => _LegendCategoryState();
}

class _LegendCategoryState extends State<LegendCategory> {
  final String apiUrl = 'https://kemet-gp2024.onrender.com/api/v1/legends';
  List<dynamic> legends = [];
  Future<Map<String, String>>? userProfileFuture;

  @override
  void initState() {
    super.initState();
    fetchData();
    userProfileFuture = fetchUserProfile();
  }

  Future<void> fetchData() async {
    try {
      var dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      var response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          legends = response.data['document'];
        });
      } else {
        print('Failed to load legends');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, String>> fetchUserProfile() async {
    try {
      final dio = Dio();
      final token = CacheHelper().getDataString(key: ApiKey.token);

      final response = await dio.get(
        'https://kemet-gp2024.onrender.com/api/v1/auth/profile',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['user'];
        final firstName = data['firstName'];
        final profileImage = data['profileImg'];
        return {
          'firstName': firstName,
          'profileImage': profileImage,
        };
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
     // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: FutureBuilder<Map<String, String>>(
                  future: userProfileFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.grey.shade200,
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: screenWidth * 0.25,
                                height: screenHeight * 0.025,
                                color: Colors.grey.shade200,
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Container(
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.018,
                                color: Colors.grey.shade200,
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final userProfile = snapshot.data!;
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Account()));
                            },
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage:
                                  NetworkImage(userProfile['profileImage']!),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, ${userProfile['firstName']}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Text(
                                'Let\'s take a tour in Egypt',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Text('No data found');
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                         onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => LegendSearch()),
                      );
                    },
                        child: Container(
                          height: screenHeight * 0.05,
                          child: Row(
                            children: [
                              SizedBox(width: screenWidth * 0.01),
                              Icon(Icons.search),
                              SizedBox(width: screenWidth * 0.03),
                              Text(
                                'Search',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              legends.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: screenWidth * 0.04,
                          mainAxisSpacing: screenHeight * 0.02,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: legends.length,
                        itemBuilder: (context, index) {
                          var legend = legends[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Legend(legend: legend),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: screenHeight * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(legend['imgCover']),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.04),
                                    child: Text(
                                      legend['name'],
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottom(
                image: 'images/Menu 1.png',
                ontap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              bottom(
                image: 'images/Menu 2.png',
                ontap: () {  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => Material(
      child: OpenStreetMapSearchAndPick(
        buttonTextStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
        // buttonColor: Colors.g,
        // buttonText: 'Set Current Location',
        onPicked: (pickedData) {
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          print(pickedData.address);
        },
        calculateRoute: (LatLng) {},
      ),
    ),
  ));},
              ),
              bottom(
                image: 'images/Menu 6.png',
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LegendCategory()));
                },
              ),
              bottom(
                image: 'images/Menu 7.png',
                ontap: () async {
                      var openAppResult = await LaunchApp.openApp(
                        androidPackageName: 'com.DefaultCompany.TestNowDeleteLater',
                      );
                      print(
                          'openAppResult => $openAppResult ${openAppResult.runtimeType}');
                      // Enter thr package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
                      // The second arguments decide wether the app redirects PlayStore or AppStore.
                      // For testing purpose you can enter com.instagram.android
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget bottom({required String image, required Function() ontap}) {
  //   return InkWell(
  //     onTap: ontap,
  //     child: Container(
  //       height: 60,
  //       width: 75,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(50),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset(image, height: 60, width: 60),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LegendCategory(),
  ));
}
