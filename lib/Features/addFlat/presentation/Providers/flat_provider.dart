import 'dart:io';
import 'package:flutter/material.dart';
import 'package:your_mediator/Features/addFlat/Services/flat_service.dart';
import 'package:your_mediator/Features/addFlat/models/add_flat_model.dart';

class AddFlatProvider with ChangeNotifier {
  final AddFlatService _flatService = AddFlatService();
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Add flat method with image and document support
  Future<bool> addFlat(AddFlatModel flat, List<File> images, List<File> documents) async {
    _isLoading = true;
    notifyListeners();

    final success = await _flatService.addFlat(flat, images, documents);

    _isLoading = false;
    if (!success) {
      _error = "Failed to add flat";
    } else {
      _error = null;
    }

    notifyListeners();
    return success;
  }
}