import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';
import 'package:kemet/models2/favorites_legand.dart';

class LegendRepository {
  final Dio _dio = Dio();
  final String baseUrl = 'https://kemet-gp2024.onrender.com/api/v1';
        final token = CacheHelper().getDataString(key: ApiKey.token);


  Future<List<Legands>> fetchLegends() async {
    try {
      final response = await _dio.get('$baseUrl/legends',options: Options(
          headers: {'token': token},
        ),);
      final List<dynamic> data = response.data['document'];
      return data.map((json) => Legands.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load legends: $error');
    }
  }
}


