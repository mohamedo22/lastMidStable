import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:your_mediator/Features/Details/widgets/customTextWidget.dart';
import 'package:your_mediator/Features/contactUs/presentation/pages/contctUs.dart';
import 'package:your_mediator/Features/Home/model/social_house_model.dart';

class SocialHouseDetails extends StatelessWidget {
  static const String routeName = "socialHouseDetails";

  final String title;
  final String description;
  final String address;
  final String category;
  final String terms;
  final List<SocialHouseImage> images;

  const SocialHouseDetails({
    super.key,
    required this.title,
    required this.description,
    required this.address,
    required this.category,
    required this.terms,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Social Housing Details",
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
          child: ListView(
            children: [
              buildImageSlider(), // Scrollable Image Slider
              const SizedBox(height: 20),
              buildPropertyDetails(), // Property Info using Customtextwidget
              const SizedBox(height: 20),
              buildContactButton(context), // Contact Us Button
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
            child: buildImage(images[index].imageBase64),
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
    } else if (imgPath.contains("base64,")) {
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

  /// **Property Details using Customtextwidget**
  Widget buildPropertyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customtextwidget(text: "Title: $title", icon: Icons.title),
        Customtextwidget(text: "Category: $category", icon: Icons.category),
        Customtextwidget(text: "Address: $address", icon: Icons.location_on),
        Customtextwidget(text: "Terms: $terms", icon: Icons.rule),
        const SizedBox(height: 10),
        const Text(
          "Description:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          description,
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
          Navigator.pushNamed(context, ContctUsScreen.routeName);
        },
        child: const Text(
          "Contact Us",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
