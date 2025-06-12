import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Home/model/flat_model.dart';
import 'package:your_mediator/Features/Home/service/flat_service.dart';

class FlatProvider with ChangeNotifier {
  final FlatServicee _flatService = FlatServicee();
  List<Flatt> _flats = [];
  List<Flatt> _filteredFlats = [];
  bool _isLoading = false;

  List<Flatt> get flats => _filteredFlats.isEmpty ? _flats : _filteredFlats;
  bool get isLoading => _isLoading;

  Future<void> loadFlats() async {
    _isLoading = true;
    notifyListeners();

    try {
      _flats = await _flatService.fetchFlats();
      _filteredFlats = []; // Reset the search list
    } catch (e) {
      debugPrint('Error loading flats: $e');
      _flats = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchFlats(String query) {
    if (query.isEmpty) {
      _filteredFlats = [];
    } else {
      _filteredFlats = _flats.where((flat) {
        final lowerQuery = query.toLowerCase();
        return flat.address.toLowerCase().contains(lowerQuery) ||
            flat.city.toLowerCase().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _filteredFlats = [];
    notifyListeners();
  }
}
