import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // For MIME type
import 'package:your_mediator/Core/Consts/api_url.dart';
import 'package:your_mediator/Features/addFlat/models/add_flat_model.dart';

class AddFlatService {
  static final String _baseUrl = "${ApiConsts.baseURL}/Flat/FlatPost";

  Future<bool> addFlat(AddFlatModel flat, List<File> images, List<File> documents) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));

      // Add form fields (other data)
      request.fields['FlatPrice'] = flat.flatPrice.toString();
      request.fields['FlatBathrooms'] = flat.flatBathrooms.toString();
      request.fields['FlatBedrooms'] = flat.flatBedrooms.toString();
      request.fields['FloorNumber'] = flat.floorNumber.toString();
      request.fields['FlatAddress'] = flat.flatAddress;
      request.fields['FlatGovernorate'] = flat.flatGovernorate;
      request.fields['FlatCity'] = flat.flatCity;
      request.fields['FlatDetails'] = flat.flatDetails;
      request.fields['FlatStatus'] = "Waiting"; // Set initial status to Waiting

      // Attach images
      for (var image in images) {
        request.files.add(await http.MultipartFile.fromPath(
          'FlatImages',
          image.path,
          contentType: MediaType('image', 'jpeg'), // Change if different image format
        ));
      }

      // Attach documents
      for (var doc in documents) {
        request.files.add(await http.MultipartFile.fromPath(
          'FlatImagesDocs',
          doc.path,
          contentType: MediaType('application', 'pdf'), // Change if needed
        ));
      }

      // Send request
      var response = await request.send();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Success: Flat added with Waiting status!");
        return true;
      } else {
        print("Error: ${response.statusCode} - ${await response.stream.bytesToString()}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}