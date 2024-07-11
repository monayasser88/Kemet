import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/models2/favorites_tourism.dart';


class OfferRepository {
  final Dio _dio = Dio();
  final String apiUrl = 'https://kemet-gp2024.onrender.com/api/v1/offers';
      final token = CacheHelper().getDataString(key: ApiKey.token);

  Future<List<TourismPlace>> fetchOffers() async {
    try {
      final response = await _dio.get(apiUrl,options: Options(
          headers: {'token': token},
        ),);
      if (response.statusCode == 200) {
        final List<dynamic> offers = response.data['offers'];
        return offers.map((json) => TourismPlace.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
