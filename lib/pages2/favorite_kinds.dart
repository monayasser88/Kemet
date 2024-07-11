import 'package:flutter/material.dart';
import 'package:kemet/components2/custom_appbar2.dart';
import 'package:kemet/components2/custom_container_in_setting.dart';
import 'package:kemet/views2/favorites_legend_view.dart';
import 'package:kemet/views2/favorites_tourism_view.dart';
import 'package:kemet/views2/favorites_trips_view.dart';

class FavoriteKinds extends StatelessWidget {
  const FavoriteKinds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(children: [
        const SizedBox(
          height: 55,
        ),
        CustomAppBar2(
          title: 'Favorite Kinds',
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FavoritesLegendPlaceView();
            }));
          },
          child: const CustomContainerSetting(
            icon: Icons.favorite,
            tileName: 'Legends',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const FavoritesTripsView();
            }
            ));
          },
          child: const CustomContainerSetting(
            icon: Icons.favorite,
            tileName: 'Trips',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FavoritesTourismPlaceView();
            }));
          },
          child: const CustomContainerSetting(
            icon: Icons.favorite,
            tileName: 'Tourism Places',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    ));
  }
}
