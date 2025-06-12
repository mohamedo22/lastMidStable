
// contact_us_provider.dart
import 'package:flutter/material.dart';
import 'package:your_mediator/Features/contactUs/Model/contact_us_model.dart';
import 'package:your_mediator/Features/contactUs/controller/contact_us_servise.dart';


class ContactUsProvider with ChangeNotifier {
  final ContactUsService _service = ContactUsService();
  bool isLoading = false;
  String? errorMessage;

  Future<void> submitRequest(ContactUsRequest request, BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      bool success = await _service.sendContactRequest(request);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Request sent successfully!")),
        );
      } else {
        throw Exception("Failed to send request");
      }
    } catch (e) {
      errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage!)),
      );
    }

    isLoading = false;
    notifyListeners();
  }
}