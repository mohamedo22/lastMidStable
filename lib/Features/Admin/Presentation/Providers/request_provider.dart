import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Admin/Models/request_model.dart';
import 'package:your_mediator/Features/Admin/Services/request_service.dart';

class RequestProvider with ChangeNotifier {
  List<RequestModel> _requests = [];
  bool _loading = false;
  String? _error;

  List<RequestModel> get requests => _requests;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchRequests() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await RequestService.fetchRequests();
      _requests = response.requests;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}