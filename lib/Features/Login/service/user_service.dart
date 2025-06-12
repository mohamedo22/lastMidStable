// UserService Class
import 'package:dio/dio.dart';
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/Login/model/auth_model.dart';

class UserService {
  Dio dio = Dio();

  Future<AuthModel?> login(String username, String password) async {
    try {
      final response = await dio.post(
        '${ApiConsts.baseURL}/User/Login', // Use relative path
        data: {'username': username, 'password': password},
        options: Options(
          contentType: 'application/json',
          // Validate only successful status codes
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 202 || response.statusCode == 404) {
        return AuthModel.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Better error handling
      if (e.response != null) {
        throw Exception('Server error: ${e.response!.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }

   Future<AuthModel?> signup({
    required String username,
    required String nationalId,
    required DateTime birthDate,
    required String phone,
    required String password,
    required String email,
    required String address,
  }) async {
    final String url = "${ApiConsts.baseURL}/User/SignUp";
    try {
      final response = await dio.post(
        url,
        data: {
          'username': username,
          'national_Id': nationalId,
          'birthDate': birthDate.toIso8601String(),
          'phone': phone,
          'password': password,
          'email': email,
          'address': address,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 202) {
        return AuthModel.fromJson(response.data);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      print('Error in signup: $e');
      throw Exception('Error: $e');
    }
  }
  
   Future<AuthModel?> getUserData(String username) async {
    final String url = "${ApiConsts.baseURL}/User/GetByUsername/$username";
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 202) {
        return AuthModel.fromJson(response.data);
      } else {
        throw Exception("Failed to get user data: ${response.statusCode}");
      }
    } catch (e) {
      print('Error getting user data: $e');
      throw Exception('Error: $e');
    }
  }
}
