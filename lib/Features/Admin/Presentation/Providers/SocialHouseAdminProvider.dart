import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Admin/Models/SocialHouseAdminModel.dart';
import 'package:your_mediator/Features/Admin/Services/SocialHouseAdminService.dart';

class SocialHouseAdminProvider with ChangeNotifier {
  final SocialHouseAdminService _socialHouseAdminService = SocialHouseAdminService();

  List<SocialHouseAdminModel> _socialHouses = [];
  bool _isLoading = false;

  List<SocialHouseAdminModel> get socialHouses => _socialHouses;
  bool get isLoading => _isLoading;

  // Load all social houses
  Future<void> loadSocialHouses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _socialHouses = await _socialHouseAdminService.getAllSocialHouses();
    } catch (e) {
      print('Error loading social houses: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Delete social house
  Future<void> deleteSocialHouse(int id) async {
    try {
      await _socialHouseAdminService.deleteSocialHouse(id);
      _socialHouses.removeWhere((house) => house.socialHouseId == id.toString());
      notifyListeners();
    } catch (e) {
      print('Error deleting social house: $e');
    }
  }

  // Add social house
  Future<void> addSocialHouse({
    required String title,
    required String description,
    required String address,
    required String category,
    required String terms,
    required List<File> imageFiles,
    required List<File> documentFiles,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _socialHouseAdminService.addSocialHouse(
        title: title,
        description: description,
        address: address,
        category: category,
        terms: terms,
        imageFiles: imageFiles,
        documentFiles: documentFiles,
      );
      await loadSocialHouses(); // Refresh the list
    } catch (e) {
      print('Error adding social house: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update social house
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
    _isLoading = true;
    notifyListeners();

    try {
      await _socialHouseAdminService.updateSocialHouse(
        socialHouseID: socialHouseID,
        title: title,
        description: description,
        address: address,
        category: category,
        terms: terms,
        imageFiles: imageFiles,
        documentFiles: documentFiles,
      );

      // Update the local list after successful update
      int index = _socialHouses.indexWhere((house) => house.socialHouseId == socialHouseID.toString());
      if (index != -1) {
        _socialHouses[index] = SocialHouseAdminModel(
          socialHouseId: socialHouseID,
          title: title,
          description: description,
          address: address,
          category: category,
          terms: terms,
          socialHouseImages: imageFiles.map((file) => SocialHouseImage(imageBase64: base64Encode(file.readAsBytesSync()))).toList(),
          socialHouseDocuments: documentFiles.map((file) => SocialHouseDocument(documentBase64: base64Encode(file.readAsBytesSync()))).toList(),
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error updating social house: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}