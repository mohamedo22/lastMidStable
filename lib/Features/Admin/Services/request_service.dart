import 'package:dio/dio.dart';
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/Admin/Models/request_model.dart';

class RequestService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConsts.baseURL,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  static Future<RequestResponse> fetchRequests() async {
    try {
      final response = await _dio.get('/ContactusControllerRequests');
      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load requests: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}