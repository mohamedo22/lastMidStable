import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/editeProfile/Model/editProfile.dart';

class EditProfileServices{
  static Dio dio = Dio();
  static Future<dynamic> editeData(userID,phone, username, email, address) async {
    try {
      Response response = await dio.patch(
        "${ApiConsts.baseURL}/User/editprof", 
        data: {
          "userId":userID,
          "phone": phone,
          "username": username,
          "email": email,
          "address": address
        }
      );
      print(response.data);
      if(response.statusCode == 202) {
        return EditeProfileModel(user: response.data);
      }
    } catch (ex) {
      print("Edit profile error: $ex");
      throw Exception(ex);
    }
  }
}