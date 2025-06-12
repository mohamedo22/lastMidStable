import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Admin/Models/flat_admin_model.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/FlatAdmin/flat_admin_page.dart';
import 'package:your_mediator/Features/Admin/Services/flat_admin_services.dart';

class FlatAdminDetails extends StatelessWidget {
  final FlatAdminModel flat;
  FlatAdminDetails({required this.flat});

  final FlatAdminServices _flatAdminServices = FlatAdminServices();

  // Accept a flat with proper error handling
  Future<void> _acceptFlat(BuildContext context, int flatId) async {
    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Text("Accepting flat..."),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );
    
    try {
      final success = await _flatAdminServices.acceptFlat(flatId);
      
      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Text("Flat accepted successfully"),
              ],
            ),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate back after a short delay
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, AllFlatsAdminScreen.routeName);
        });
      } else {
        throw Exception("Failed to accept flat");
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text("Error accepting flat: ${e.toString()}")),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  // Reject a flat with proper error handling
  Future<void> _rejectFlat(BuildContext context, int flatId) async {
    try {
      final rejectSuccess = await _flatAdminServices.rejectFlat(flatId);
      if (!rejectSuccess) {
        throw Exception("Failed to reject flat");
      }
      
      final deleteSuccess = await _flatAdminServices.deleteFlat(flatId);
      if (!deleteSuccess) {
        throw Exception("Failed to delete flat");
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text("Flat rejected and deleted"),
            ],
          ),
          backgroundColor: Colors.red.shade700,
        ),
      );
      
      Navigator.pushReplacementNamed(context, AllFlatsAdminScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text("Error rejecting flat: ${e.toString()}")),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Flat ${flat.flatCode} Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(
                base64Decode(flat.flatImages.first),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text("Price: ${flat.flatPrice}\$", style: TextStyle(fontSize: 20, color: Colors.black)),
              Text("City: ${flat.flatCity}", style: TextStyle(color: Colors.black)),
              Text("Bedrooms: ${flat.flatBedrooms}", style: TextStyle(color: Colors.black)),
              Text("Bathrooms: ${flat.flatBathrooms}", style: TextStyle(color: Colors.black)),
              Text("Floor: ${flat.floorNumber}", style: TextStyle(color: Colors.black)),
              Text("Address: ${flat.flatAddress}", style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  _buildStatusChip(flat.flatStatus),
                ],
              ),
              SizedBox(height: 10),
              Text("Details:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              Text(flat.flatDetails, style: TextStyle(color: Colors.black)),
              SizedBox(height: 20),

              // Display Documents
              if (flat.documents.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Documents:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ...flat.documents.map((doc) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(doc, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ],
                ),

              SizedBox(height: 20),
              
              // Row with action buttons based on status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Only show "Accept" button if flatStatus is "Waiting"
                  if (flat.flatStatus == "Waiting")
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () => _acceptFlat(context, flat.flatCode),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text("Accept"),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,  // Green color for Accept button
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  if (flat.flatStatus == "Waiting") SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Show confirmation dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Reject Flat'),
                            content: Text('Are you sure you want to reject this flat?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  _rejectFlat(context, flat.flatCode);
                                },
                                child: Text('Reject'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text("Reject"),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,  // Red color for Reject button
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status) {
      case "Waiting":
        chipColor = Colors.orange;
        break;
      case "accepting":
        chipColor = Colors.green;
        break;
      case "rejected":
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      label: Text(
        status,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: chipColor,
    );
  }
}