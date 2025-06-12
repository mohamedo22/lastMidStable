import 'dart:convert';
import 'dart:io';

class AddFlatModel {
  final int flatPrice;
  final int flatBathrooms;
  final int flatBedrooms;
  final int floorNumber;
  final String flatAddress;
  final String flatGovernorate;
  final String flatCity;
  final String flatDetails;

  AddFlatModel({
    required this.flatPrice,
    required this.flatBathrooms,
    required this.flatBedrooms,
    required this.floorNumber,
    required this.flatAddress,
    required this.flatGovernorate,
    required this.flatCity,
    required this.flatDetails,
  });

  // Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      "flatPrice": flatPrice,
      "flatBathrooms": flatBathrooms,
      "flatBedrooms": flatBedrooms,
      "floorNumber": floorNumber,
      "flatAddress": flatAddress,
      "flatGovernorate": flatGovernorate,
      "flatCity": flatCity,
      "flatDetails": flatDetails,
    };
  }
}

// Helper function to convert an image file to Base64
String convertImageToBase64(File imageFile) {
  List<int> imageBytes = imageFile.readAsBytesSync();
  return base64Encode(imageBytes);
}