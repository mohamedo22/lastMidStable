import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Home/model/flat_model.dart';
import 'package:your_mediator/Features/Details/presentation/flatDetailsPage.dart';

class FlatDetailsScreen extends StatelessWidget {
  final Flatt flat;

  const FlatDetailsScreen({Key? key, required this.flat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the existing Detailspage widget to display the flat details
    return Detailspage(
      flatCode: flat.flatCode,
      price: flat.price,
      bathrooms: flat.bathrooms,
      bedrooms: flat.bedrooms,
      floorNumber: flat.floorNumber,
      governorate: flat.governorate,
      city: flat.city,
      details: flat.details,
      address: flat.address,
      images: flat.images,
    );
  }
} 