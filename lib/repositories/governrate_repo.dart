import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';

import '../models2/favorites_tourism.dart';

class GovernatesRepository {
  final Dio _dio = Dio();
  final String baseUrl;
        final token = CacheHelper().getDataString(key: ApiKey.token);


  GovernatesRepository({required this.baseUrl});

  Future<List<Governate>> fetchGovernates() async {
    try {
      Response response = await _dio.get('$baseUrl/governrates?sort=createdAt',options: Options(
          headers: {'token': token},
        ),);

      if (response.statusCode == 200) {
        final List<dynamic> governatesData = response.data['document'];

        List<Governate> governates = governatesData.map((item) {
          return Governate.fromJson(item);
        }).toList();

        return governates;
      } else {
        throw Exception('Failed to load governates');
      }
    } catch (e) {
      throw Exception('Failed to fetch governates: $e');
    }
  }
}
