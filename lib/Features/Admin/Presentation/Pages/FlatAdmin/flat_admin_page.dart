import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Admin/Models/flat_admin_model.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Contact-Us/requests_screen.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/FlatAdmin/flat_admin_details.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Social_housing_admin/SocialHouseAdminScreen.dart';
import 'package:your_mediator/Features/Admin/Presentation/Providers/flat_admin_provider.dart';
import 'package:your_mediator/Features/Admin/Presentation/widgets/searchWidget.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/login_screen.dart';

class AllFlatsAdminScreen extends StatefulWidget {
  static const String routeName = "AllFlatsAdminScreen";

  @override
  _AllFlatsScreenState createState() => _AllFlatsScreenState();
}

class _AllFlatsScreenState extends State<AllFlatsAdminScreen> {
  // Controller to manage search input
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  
  @override
  void initState() {
    super.initState();
    // Delay the call to loadFlats until after the current build phase
    Future.microtask(() {
      Provider.of<FlatAdminProvider>(context, listen: false).loadFlats();
    });
  }

  // Filter flats based on the search query
  List<FlatAdminModel> _filterFlats(List<FlatAdminModel> flats) {
    if (_searchQuery.isEmpty) {
      return flats;
    } else {
      return flats.where((flat) {
        return flat.flatCity.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            flat.flatCode.toString().contains(_searchQuery);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }
        ),
        title: Text("Flats Management", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: FlatSearchDelegate(
                  onSearchQueryChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  flats: Provider.of<FlatAdminProvider>(context, listen: false).flats,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<FlatAdminProvider>(context, listen: false).loadFlats();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: theme.primaryColor.withOpacity(0.2)),
        ),
      ),
      body: Column(
        children: [
          // Admin Navigation
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Admin Dashboard",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavButton(
                      context,
                      "Contact Requests",
                      Icons.message,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RequestsScreen.routeName);
                      },
                    ),
                    _buildNavButton(
                      context,
                      "Flats",
                      Icons.apartment,
                      isActive: true,
                      onPressed: () {},
                    ),
                    _buildNavButton(
                      context,
                      "Social Housing",
                      Icons.home_work,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SocialHouseAdminScreen.routeName);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filtering options
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip("All", true),
                SizedBox(width: 8),
                _buildFilterChip("Waiting", false),
                SizedBox(width: 8),
                _buildFilterChip("Accepted", false),
                SizedBox(width: 8),
                _buildFilterChip("Rejected", false),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Consumer<FlatAdminProvider>(
                    builder: (context, provider, _) => Text(
                      "${provider.flats.length} Flats",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 1, thickness: 1, color: Colors.grey[200]),
          
          // Flats list
          Expanded(
            child: Consumer<FlatAdminProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          "Loading flats...",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                // Filter flats based on the search query
                List<FlatAdminModel> filteredFlats = _filterFlats(provider.flats);

                if (filteredFlats.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apartment_outlined,
                          color: Colors.grey[400],
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No flats found",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Try changing your search or filter criteria",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredFlats.length,
                  itemBuilder: (context, index) {
                    final flat = filteredFlats[index];
                    Color statusColor;
                    Color cardColor;
                    
                    switch(flat.flatStatus) {
                      case "accepting":
                        statusColor = Colors.green;
                        cardColor = Colors.green.withOpacity(0.05);
                        break;
                      case "Waiting":
                        statusColor = Colors.orange;
                        cardColor = Colors.orange.withOpacity(0.05);
                        break;
                      case "rejected":
                        statusColor = Colors.red;
                        cardColor = Colors.red.withOpacity(0.05);
                        break;
                      default:
                        statusColor = Colors.grey;
                        cardColor = Colors.white;
                    }

                    return Card(
                      color: Colors.white,
                      elevation: 3,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: statusColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FlatAdminDetails(flat: flat),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image and status indicator
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.memory(
                                    base64Decode(flat.flatImages.first),
                                    width: double.infinity,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      flat.flatStatus,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Flat details
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          flat.flatCity,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Flat ${flat.flatCode}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${flat.flatPrice}\$",
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      _buildFeatureChip(Icons.bed, "${flat.flatBedrooms}"),
                                      SizedBox(width: 8),
                                      _buildFeatureChip(Icons.bathtub, "${flat.flatBathrooms}"),
                                      Spacer(),
                                      if (provider.isAdmin)
                                        IconButton(
                                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            _showDeleteDialog(context, provider, flat);
                                          },
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavButton(
    BuildContext context,
    String label,
    IconData icon, {
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isActive ? Colors.white : theme.primaryColor,
          size: 20,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : theme.primaryColor,
            fontSize: 12,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? theme.primaryColor : Colors.white,
          foregroundColor: isActive ? Colors.white : theme.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: theme.primaryColor,
              width: 1,
            ),
          ),
          elevation: isActive ? 2 : 0,
        ),
      ),
    );
  }
  
  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[800],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  
  Widget _buildFeatureChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[600]),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteDialog(BuildContext context, FlatAdminProvider provider, FlatAdminModel flat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Flat'),
        content: Text('Are you sure you want to delete Flat ${flat.flatCode}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.delete_outline, size: 18),
            label: Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await provider.flatService.deleteFlat(flat.flatCode);
              Navigator.pop(context);
              provider.loadFlats();
            },
          ),
        ],
      ),
    );
  }
}
