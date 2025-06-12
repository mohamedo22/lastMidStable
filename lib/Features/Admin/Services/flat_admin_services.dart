import 'package:dio/dio.dart';
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/Admin/Models/flat_admin_model.dart';

class FlatAdminServices {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConsts.baseURL}/Flat";

  Future<List<FlatAdminModel>> fetchFlats() async {
    try {
      final response = await _dio.get("${baseUrl}/getWithStatus");
      List<dynamic> data = response.data['flats'];
      List<FlatAdminModel> flats = data
          .map((json) => FlatAdminModel.fromJson(json))
          .toList();
      return flats;
    } catch (e) {
      print("Error fetching flats: $e");
      return [];
    }
  }

  Future<bool> updateFlatStatus(int flatId, String status) async {
    try {
      print("Updating flat $flatId to status: $status");
      final response = await _dio.patch(
        '$baseUrl/FlatEdit',
        queryParameters: {
          'FlatStatus': status,
          'id': flatId,
        },
      );
      print("Flat status updated: ${response.data}");
      return true;
    } catch (e) {
      print("Error updating flat status: $e");
      if (e is DioException) {
        print("Status code: ${e.response?.statusCode}");
        print("Response data: ${e.response?.data}");
      }
      throw Exception("Failed to update flat status: $e");
    }
  }

  Future<bool> acceptFlat(int flatId) async {
    return await updateFlatStatus(flatId, "accepting");
  }

  Future<bool> rejectFlat(int flatId) async {
    return await updateFlatStatus(flatId, "rejected");
  }

  Future<bool> deleteFlat(int flatId) async {
    try {
      final response = await _dio.delete('$baseUrl/$flatId');
      print("Flat deleted: ${response.data}");
      return true;
    } catch (e) {
      print("Error deleting flat: $e");
      if (e is DioException) {
        print("Status code: ${e.response?.statusCode}");
        print("Response data: ${e.response?.data}");
      }
      throw Exception("Failed to delete flat: $e");
    }
  }
}