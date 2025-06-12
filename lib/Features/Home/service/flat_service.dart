import 'package:dio/dio.dart';
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/Home/model/flat_model.dart';

class FlatServicee {
  final Dio _dio = Dio();

  Future<List<Flatt>> fetchFlats() async {
    try {

      final response = await _dio.get('${ApiConsts.baseURL}/Flat');

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 ) {
        final Map<String, dynamic> data = response.data;
        List<Flatt> flats = (data['flats'] as List)
            .map((flatJson) => Flatt.fromJson(flatJson))
            .where((flat) => flat.flatStatus == "Approved") // Only show accepted flats
            .toList();
        return flats;
      } else {
        throw Exception('Failed to load flats');
      }
    } catch (e) {
      throw Exception('Error fetching flats: $e');
    }
  }
}
