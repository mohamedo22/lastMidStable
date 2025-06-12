import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Admin/Models/flat_admin_model.dart';

class FlatSearchDelegate extends SearchDelegate {
  final Function(String) onSearchQueryChanged;
  final List<FlatAdminModel> flats;

  FlatSearchDelegate({required this.onSearchQueryChanged, required this.flats});

  @override
  Widget buildSuggestions(BuildContext context) {
    final query = this.query;
    final List<FlatAdminModel> suggestions = flats.where((flat) {
      return flat.flatCity.toLowerCase().contains(query.toLowerCase()) ||
          flat.flatCode.toString().contains(query);
    }).toList();

    return Container(
      color: Colors.white,  // Set the background color to white
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final flat = suggestions[index];
          return ListTile(
            title: Text("Flat ${flat.flatCode} - ${flat.flatPrice}\$"),
            subtitle: Text(flat.flatCity),
            onTap: () {
              onSearchQueryChanged(query);
              showResults(context);
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.white,  // Set the background color to white
      child: Center(
        child: Text("No Results Found"),  // Display message if no results
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search when the back button is pressed
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions to perform when the search bar is active
    if (query.isEmpty) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = ''; // Clear the search query
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            onSearchQueryChanged(query); // Apply the search query
            close(context, query); // Close the search after applying the query
          },
        ),
      ];
    }
  }
}
