import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/newgov_dart_cubit.dart';
import 'package:kemet/cubit/newgov_dart_state.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/pages2/governorate.dart';
import 'package:kemet/screens/governates_screens.dart';
import 'package:kemet/widget/imagegover.dart';

class Governoratesnew extends StatelessWidget {
  Governoratesnew({Key? key}) : super(key: key);

  final DioConsumer dioConsumer = DioConsumer(dio: Dio());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubitnew(api: dioConsumer)
        ..fetchGovernoratesnew(dioConsumer.dio),
      child: BlocConsumer<UserDataCubitnew, UserDataStatenew>(
        listener: (context, state) {
          // Implement listener if needed
        },
        builder: (context, state) {
          if (state is GovernrateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GovernrateSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.governorates.length +
                              1, // Add one for the "See All" option
                          itemBuilder: (context, index) {
                            if (index < state.governorates.length) {
                              final governorate = state.governorates[index];

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: imagecover(
                                  ontap: () {
                                    // final idgovernrate = CacheHelper().getDataString(key: ApiKey.idgovernrate);
                                    //final governate = state[index];

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ToristPlace(
                                          governateId: governorate.id,
                                        ),
                                      ),
                                    );
                                  },
                                  flexvalue: 1,
                                  width: 125,
                                  height: double.infinity,
                                  radius: BorderRadius.circular(10),
                                  image: governorate.image,
                                  text: governorate.name,
                                ),
                              );
                            } else {
                              // Last container for "See All"
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            GovernatesScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 125,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/egypt2.jpg'), // Replace with your image URL
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          color: Colors.black54,
                                          width: double.infinity,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text(
                                            'See All',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is GovernrateError) {
            return Center(child: Text(state.error));
          } else {
            return Container(); // Placeholder for other states
          }
        },
      ),
    );
  }
}
