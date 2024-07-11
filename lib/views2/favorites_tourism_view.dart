import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/components2/custom_appbar.dart';
import 'package:kemet/components2/favorites_tourism_list_view.dart';
import 'package:kemet/cubit2/favorites_cubit.dart';


class FavoritesTourismPlaceView extends StatelessWidget {
  const FavoritesTourismPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            const SizedBox(
              height: 55,
            ),
            CustomAppBar(
              title: 'Favorites',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: BlocProvider(
              create: (context) =>
                  FavoritesCubit()..fetchFavoriteTourismPlaces(Dio()),
              child: const FavoritesTourismListView(),
            ))
          ],
        ),
      ),
    );
  }
}
