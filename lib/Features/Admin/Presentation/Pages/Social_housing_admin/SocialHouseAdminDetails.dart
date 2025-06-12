import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Admin/Models/SocialHouseAdminModel.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Social_housing_admin/AddSocialHouseAdminScreen.dart';

class SocialHouseAdminDetails extends StatelessWidget {
  final SocialHouseAdminModel socialHouse;

  SocialHouseAdminDetails({required this.socialHouse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(socialHouse.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Images
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: socialHouse.socialHouseImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.memory(
                      base64Decode(socialHouse.socialHouseImages[index].imageBase64),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text("Description: ${socialHouse.description}"),
            Text("Address: ${socialHouse.address}"),
            Text("Category: ${socialHouse.category}"),
            Text("Terms: ${socialHouse.terms}"),
            SizedBox(height: 16),
            // Display Documents
            Text("Documents:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: socialHouse.socialHouseDocuments.map((doc) {
                return Chip(
                  label: Text('Document ${socialHouse.socialHouseDocuments.indexOf(doc) + 1}'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Update Screen
              },
              child: Text("Edit"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSocialHouseAdminScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}