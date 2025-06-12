import 'dart:io';
import 'package:dio/dio.dart';
import 'package:your_mediator/Features/Admin/Models/SocialHouseAdminModel.dart';

class SocialHouseAdminService {
  static const String apiUrl = 'https://yourmediatorapi.runasp.net/api/SocialHouse';
  final Dio _dio = Dio();

  // Fetch all Social Houses
  Future<List<SocialHouseAdminModel>> getAllSocialHouses() async {
    try {
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => SocialHouseAdminModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Delete a specific Social House by ID
  Future<void> deleteSocialHouse(int id) async {
    try {
      final response = await _dio.delete('$apiUrl?id=$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete Social House');
      }
    } catch (e) {
      throw Exception('Failed to delete Social House: $e');
    }
  }

  // Add a new Social House
  Future<void> addSocialHouse({
    required String title,
    required String description,
    required String address,
    required String category,
    required String terms,
    required List<File> imageFiles,
    required List<File> documentFiles,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'description': description,
        'address': address,
        'category': category,
        'terms': terms,
        'socialHouseImages': imageFiles.map((file) => MultipartFile.fromFileSync(file.path)).toList(),
        'socialHouseDocuments': documentFiles.map((file) => MultipartFile.fromFileSync(file.path)).toList(),
      });

      final response = await _dio.post(apiUrl, data: formData);

      if (response.statusCode != 200) {
        throw Exception('Failed to add Social House');
      }
    } catch (e) {
      throw Exception('Failed to add Social House: $e');
    }
  }

  // Update an existing Social House
  Future<void> updateSocialHouse({
    required int socialHouseID,
    required String title,
    required String description,
    required String address,
    required String category,
    required String terms,
    required List<File> imageFiles,
    required List<File> documentFiles,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'socialHouseID': socialHouseID,
        'title': title,
        'description': description,
        'address': address,
        'category': category,
        'terms': terms,
        'socialHouseImages': imageFiles.map((file) => MultipartFile.fromFileSync(file.path)).toList(),
        'socialHouseDocuments': documentFiles.map((file) => MultipartFile.fromFileSync(file.path)).toList(),
      });

      final response = await _dio.put(apiUrl, data: formData);

      if (response.statusCode != 200) {
        throw Exception('Failed to update Social House');
      }
    } catch (e) {
      throw Exception('Failed to update Social House: $e');
    }
  }
}