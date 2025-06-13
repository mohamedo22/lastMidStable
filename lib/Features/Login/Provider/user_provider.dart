import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Login/model/auth_model.dart';
import 'package:your_mediator/Features/Login/service/user_service.dart';

class UserProvider with ChangeNotifier {
  AuthModel? user;
  bool _loading = false; // Add loading state

  bool get loading => _loading; // Getter for loading state

  Future<void> login(String username, String password) async {
    _loading = true; // Set loading to true
    notifyListeners();

    try {
      user = await UserService().login(username, password);
    } catch (e) {
      // Handle error if needed
      rethrow;
    } finally {
      _loading = false; // Set loading to false
      notifyListeners();
    }
  }

  Future<void> signup({
    required String username,
    required String nationalId,
    required DateTime birthDate,
    required String phone,
    required String password,
    required String email,
    required String address,
  }) async {
    _loading = true;
    notifyListeners();
    
    try {
      user = await UserService().signup(
        username: username,
        nationalId: nationalId,
        birthDate: birthDate,
        phone: phone,
        password: password,
        email: email,
        address: address,
      );
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  Future<bool> updatePassword(userID,oldPassword,newPassword) async{
    print("prov");
    var state = UserService().updatePassword(userID,oldPassword, newPassword);
    return state;
  }
  Future<void> refreshUserData() async {
    if (user == null) return;
    
    _loading = true;
    notifyListeners();
    
    try {
      // Get current username to refresh data
      final userID = user?.user?.userId;
      if (userID != null) {
        user = await UserService().getUserData(userID);
      }
    } catch (e) {
      print("Error refreshing user data: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}