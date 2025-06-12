import 'package:dio/dio.dart';
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/Home/model/social_house_model.dart';

class SocialHouseService {

  static final Dio _dio = Dio();

  static Future<List<SocialHouse>> fetchSocialHouses() async {
    try {
      final response = await _dio.get(
        "${ApiConsts.baseURL}/SocialHouse",
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200 || response.statusCode == 202) {
        List<dynamic> data = response.data;
        List<SocialHouse> houses =
            data.map((json) => SocialHouse.fromJson(json)).toList();
        return houses;
      } else {
        throw Exception(
            "Failed to load social houses. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching social houses: $e');
      throw Exception('Error: $e');
    }
  }
}
