import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/contactUs/Model/contact_us_model.dart';

class ContactUsService {
  static const String apiUrl = "${ApiConsts.baseURL}/ContactusControllerRequests";
  final Dio _dio = Dio();

  Future<bool> sendContactRequest(ContactUsRequest request) async {
    try {
      final response = await _dio.post(
        apiUrl,
        data: jsonEncode(request.toJson()),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error sending contact request: $e");
      return false;
    }
  }
}
