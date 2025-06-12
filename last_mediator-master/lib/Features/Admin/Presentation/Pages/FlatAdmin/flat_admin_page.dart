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
  String _selectedFilter = "All";
  
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
    // First filter by status if needed
    var filteredByStatus = flats;
    if (_selectedFilter != "All") {
      filteredByStatus = flats.where((flat) => flat.flatStatus == _selectedFilter).toList();
    }
    
    // Then filter by search query
    if (_searchQuery.isEmpty) {
      return filteredByStatus;
    } else {
      return filteredByStatus.where((flat) {
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
          preferredSize: Size.fromHeight(120),
          child: Container(
            color: theme.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Text(
                    "Flats Management Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildAdminNav(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filtering options
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Filter by Status:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip("All", _selectedFilter == "All"),
                      SizedBox(width: 8),
                      _buildFilterChip("Waiting", _selectedFilter == "Waiting"),
                      SizedBox(width: 8),
                      _buildFilterChip("accepting", _selectedFilter == "accepting"),
                      SizedBox(width: 8),
                      _buildFilterChip("rejected", _selectedFilter == "rejected"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 1, thickness: 1, color: Colors.grey[200]),
          
          // Stats row
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Consumer<FlatAdminProvider>(
              builder: (context, provider, _) {
                int totalFlats = provider.flats.length;
                int waitingFlats = provider.flats.where((flat) => flat.flatStatus == "Waiting").length;
                int acceptedFlats = provider.flats.where((flat) => flat.flatStatus == "accepting").length;
                
                return Row(
                  children: [
                    _buildStatCard(
                      "Total Flats",
                      totalFlats.toString(),
                      Icons.apartment,
                      theme.primaryColor,
                    ),
                    SizedBox(width: 8),
                    _buildStatCard(
                      "Waiting",
                      waitingFlats.toString(),
                      Icons.pending_actions,
                      Colors.orange,
                    ),
                    SizedBox(width: 8),
                    _buildStatCard(
                      "Accepted",
                      acceptedFlats.toString(),
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ],
                );
              },
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
                
                // Filter flats based on the search query and status
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
                    Color cardBorderColor;
                    
                    switch(flat.flatStatus) {
                      case "accepting":
                        statusColor = Colors.green;
                        cardBorderColor = Colors.green.withOpacity(0.3);
                        break;
                      case "Waiting":
                        statusColor = Colors.orange;
                        cardBorderColor = Colors.orange.withOpacity(0.3);
                        break;
                      case "rejected":
                        statusColor = Colors.red;
                        cardBorderColor = Colors.red.withOpacity(0.3);
                        break;
                      default:
                        statusColor = Colors.grey;
                        cardBorderColor = Colors.grey.withOpacity(0.3);
                    }

                    return Card(
                      color: Colors.white,
                      elevation: 3,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: cardBorderColor,
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
  
  Widget _buildAdminNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavItem(
          context, 
          icon: Icons.message,
          label: "Contact Requests",
          onTap: () {
            Navigator.pushReplacementNamed(context, RequestsScreen.routeName);
          },
        ),
        _buildNavItem(
          context, 
          icon: Icons.apartment,
          label: "Flats",
          isActive: true,
          onTap: () {},
        ),
        _buildNavItem(
          context, 
          icon: Icons.home_work,
          label: "Social Housing",
          onTap: () {
            Navigator.pushReplacementNamed(context, SocialHouseAdminScreen.routeName);
          },
        ),
      ],
    );
  }
  
  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? theme.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive 
              ? Border.all(color: theme.primaryColor.withOpacity(0.3))
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? theme.primaryColor : Colors.grey[600],
              size: 20,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? theme.primaryColor : Colors.grey[600],
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFilterChip(String label, bool isSelected) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.grey[200],
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
      ),
    );
  }
  
  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontSize: 10,
              ),
            ),
          ],
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