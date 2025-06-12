import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Home/model/social_house_model.dart';
import 'package:your_mediator/Features/Home/service/social_house_service.dart';

class SocialHouseProvider with ChangeNotifier {
  List<SocialHouse> _houses = [];
  bool _isLoading = false;
  String? _error;

  List<SocialHouse> get houses => _houses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadSocialHouses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _houses = await SocialHouseService.fetchSocialHouses();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
