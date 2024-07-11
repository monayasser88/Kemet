//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/cubit/governorate_cubit.dart';
import 'package:kemet/models2/favorites_tourism.dart';
import 'package:kemet/pages2/governorate.dart';
import 'package:kemet/pages2/governorate_search.dart';
import 'package:kemet/pages2/tourism_search.dart';
import 'package:kemet/repositories/governrate_repo.dart';
import 'package:kemet/screens/card%20gov.dart';
import 'package:kemet/screens/homepage.dart';

class GovernatesScreen extends StatelessWidget {
  final String baseUrl = 'https://kemet-gp2024.onrender.com/api/v1';
  final GovernatesRepository governatesRepository = GovernatesRepository(
    baseUrl: 'https://kemet-gp2024.onrender.com/api/v1',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 5.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                 const Text(
                    'Governorates',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                 const SizedBox(width: 40.0), // Adjust as needed for spacing
                ],
              ),
            const  SizedBox(height: 20.0),
              Row(
                children: [
                  GestureDetector(
                    // onTap: () {
                    //  Navigator.of(context).push(
                    //  MaterialPageRoute(builder: (context) => Search()),
                    // );
                    // },
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>const GovernorateSearch()),
                      );
                    },
                    child: Padding(
                      padding:const EdgeInsets.only(left: 20),
                      child: Container(
                        width: 354,
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
            const  SizedBox(height: 30),
              BlocProvider(
                create: (context) =>
                    GovernatesCubit(governatesRepository: governatesRepository)
                      ..fetchGovernates(),
                child: BlocBuilder<GovernatesCubit, List<Governate>>(
                  builder: (context, state) {
                    if (state.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics:
                        const    NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio:
                              0.75, // Aspect ratio of the card (width / height)
                        ),
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          final governate = state[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to ToristPlace screen with selected governateId
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ToristPlace(governateId: governate.id),
                                ),
                              );
                            },
                            child: CategoryCard(governate: governate),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
