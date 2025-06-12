import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Admin/Models/flat_admin_model.dart';
import 'package:your_mediator/Features/Admin/Services/flat_admin_services.dart';

class FlatAdminProvider extends ChangeNotifier {
  List<FlatAdminModel> _flats = [];
  bool _isLoading = false;
  bool _isAdmin = false;

  List<FlatAdminModel> get flats => _flats;
  bool get isLoading => _isLoading;
  bool get isAdmin => _isAdmin;

  final FlatAdminServices flatService = FlatAdminServices();

  Future<void> loadFlats() async {
    _isLoading = true;
    // Delay notifyListeners() until after the current build phase
    Future.microtask(() => notifyListeners());

    _flats = await flatService.fetchFlats();
    _isLoading = false;
    // Delay notifyListeners() until after the current build phase
    Future.microtask(() => notifyListeners());
  }

  void setAdminStatus(bool status) {
    _isAdmin = status;
    // Delay notifyListeners() until after the current build phase
    Future.microtask(() => notifyListeners());
  }
}