import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:your_mediator/Features/Details/presentation/social_house_details.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/home_screen.dart';
import 'package:your_mediator/Features/Home/Peresintation/Providers/social_house_provider.dart';
import 'package:your_mediator/Features/Home/model/social_house_model.dart';
import 'package:your_mediator/Features/userProfile/presentation/pages/userProfile.dart';

class SocialHouseScreen extends StatefulWidget {
  static const String routeName = "socialhouse";
  const SocialHouseScreen({Key? key}) : super(key: key);

  @override
  _SocialHouseScreenState createState() => _SocialHouseScreenState();
}

class _SocialHouseScreenState extends State<SocialHouseScreen> {
  @override
  void initState() {
    super.initState();
    // Load the social houses after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SocialHouseProvider>(context, listen: false).loadSocialHouses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.pushNamed(context, Userprofile.routeName);
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<SocialHouseProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSearchBar(context),
                const SizedBox(height: 16),
                buildSortOptions(context),
                const SizedBox(height: 16),
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.houses.isEmpty
                      ? const Center(child: Text("No social houses found"))
                      : ListView.builder(
                    itemCount: provider.houses.length,
                    itemBuilder: (context, index) {
                      final house = provider.houses[index];
                      return _buildHouseCard(context, house);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Build the search bar using Expanded widgets.
  Widget buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  // Handle search action.
                },
                child: const Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the sort options buttons.
  Widget buildSortOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildSortButton('Social Housing', context, "assets/images/SocialHousind.png", 1),
        Container(
          height: 55,
          width: 1,
          color: Colors.black,
        ),
        buildSortButton('Flat', context, "assets/images/Flat.png", 2),
      ],
    );
  }

  // Helper function to create sort buttons.
  Widget buildSortButton(String label, BuildContext context, String image, int index) {
    return ElevatedButton(
      onPressed: () {
        if (index == 2) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Provider.of<SocialHouseProvider>(context, listen: false).loadSocialHouses();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[600],
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(image),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }

  // Build the card for a single social house.
  Widget _buildHouseCard(BuildContext context, SocialHouse house) {
    // Try to display the first image (if available) by decoding the Base64 string.
    Widget imageWidget;
    if (house.images.isNotEmpty && house.images[0].imageBase64.isNotEmpty) {
      try {
        final bytes = base64Decode(house.images[0].imageBase64);
        imageWidget = Image.memory(
          bytes,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        );
      } catch (e) {
        imageWidget = Container(
          color: Colors.grey,
          height: 200,
          child: const Center(child: Text("Image error")),
        );
      }
    } else if (house.images.isNotEmpty && house.images[0].imageBase64.isNotEmpty) {
      // Use CachedNetworkImage for network images
      imageWidget = CachedNetworkImage(
        imageUrl: house.images[0].imageBase64,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
        placeholder: (context, url) => Container(
          color: Colors.grey,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey,
          child: const Center(child: Icon(Icons.error)),
        ),
      );
    } else {
      imageWidget = Container(
        color: Colors.grey,
        height: 200,
        child: const Center(child: Text("No image")),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imageWidget,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  house.address,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  house.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialHouseDetails(
                              title: house.title,
                              description: house.description,
                              address: house.address,
                              category: house.category,
                              terms: house.terms,
                              images: house.images,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Details'),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}