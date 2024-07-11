import 'package:flutter/material.dart';
import 'package:kemet/pages2/favorite_kinds.dart';


class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FavoriteKinds()
        );
  }
}
