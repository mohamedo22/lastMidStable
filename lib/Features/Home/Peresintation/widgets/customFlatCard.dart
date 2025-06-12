import 'package:flutter/material.dart';

class Customflatcard extends StatelessWidget {
  Customflatcard({super.key,
    required this.location,
    required this.price,
    required this.details,
    required this.imagePath,
  });
  String imagePath;
  String location;
  String price;
  String details;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(imagePath, height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(location, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                const SizedBox(height: 8),
                Text(price, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
                const SizedBox(height: 8),
                Text(details, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle details action
                  },
                  child: const Text('Details'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
