import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Details/widgets/customTextWidget.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/contactUs/presentation/pages/contctUs.dart';

class Detailspage extends StatelessWidget {
  static const String routeName = "DetailsPage";

  final double price;
  final int bathrooms;
  final int bedrooms;
  final int floorNumber;
  final String governorate;
  final String city;
  final String details;
  final String address;
  final int flatCode;
  final List<String> images;

  const Detailspage({
    super.key,
    required this.flatCode,
    required this.price,
    required this.bathrooms,
    required this.bedrooms,
    required this.floorNumber,
    required this.governorate,
    required this.city,
    required this.details,
    required this.address,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Property Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // Image Slider
              buildImageSlider(),
              const SizedBox(height: 20),

              // Property Details
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildPropertyDetails(),
                      const SizedBox(height: 20),
                      buildContactButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Horizontally Scrollable Image Slider**
  Widget buildImageSlider() {
    if (images.isEmpty) {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: const Center(
          child: Text("No Images Available", style: TextStyle(fontSize: 16, color: Colors.grey)),
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: buildImage(images[index]),
          );
        },
      ),
    );
  }

  /// **Handles Different Image Formats (Network/Base64)**
  Widget buildImage(String imgPath) {
    if (imgPath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imgPath,
        fit: BoxFit.cover,
        width: 300,
        height: 250,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error, size: 50)),
      );
    } else if (imgPath.contains("data:image/png;base64,")) {
      try {
        final bytes = base64Decode(imgPath.split(',')[1]);
        return Image.memory(bytes, width: 300, height: 250, fit: BoxFit.cover);
      } catch (e) {
        return const Center(child: Text("Image Error"));
      }
    } else {
      return Container(
        width: 300,
        height: 250,
        color: Colors.grey[300],
        child: const Center(child: Text("Invalid Image Format")),
      );
    }
  }

  /// **Scrollable Property Details using Customtextwidget**
  Widget buildPropertyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customtextwidget(text: "Price: $price L.E", icon: Icons.monetization_on),
        Customtextwidget(text: "Bedrooms: $bedrooms", icon: Icons.bed),
        Customtextwidget(text: "Bathrooms: $bathrooms", icon: Icons.bathtub),
        Customtextwidget(text: "Floor: $floorNumber", icon: Icons.format_list_numbered),
        Customtextwidget(text: "Governorate: $governorate", icon: Icons.location_city),
        Customtextwidget(text: "City: $city", icon: Icons.location_on),
        Customtextwidget(text: "Address: $address", icon: Icons.home),
        const SizedBox(height: 10),
        const Text(
          "Property Details:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          details,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          softWrap: true,
        ),
      ],
    );
  }

  /// **Contact Us Button**
  Widget buildContactButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContctUsScreen(
                phone: userProvider.user?.user?.phone ?? "",
                email: userProvider.user?.user?.email ?? "",
                flatCode: flatCode,
                userName: userProvider.user?.user?.username ?? "null",
                userId: userProvider.user?.user?.userId ?? 0,
              ),
            ),
          );
        },
        child: const Text(
          "Contact Us",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}