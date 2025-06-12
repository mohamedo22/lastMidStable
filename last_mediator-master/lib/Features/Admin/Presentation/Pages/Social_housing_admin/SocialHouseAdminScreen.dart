import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Contact-Us/requests_screen.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/FlatAdmin/flat_admin_page.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Social_housing_admin/AddSocialHouseAdminScreen.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Social_housing_admin/SocialHouseAdminDetails.dart';
import 'package:your_mediator/Features/Admin/Presentation/Providers/SocialHouseAdminProvider.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/login_screen.dart';

class SocialHouseAdminScreen extends StatefulWidget {
  static const String routeName = "SocialHouseAdminScreen";

  @override
  _SocialHouseAdminScreenState createState() => _SocialHouseAdminScreenState();
}

class _SocialHouseAdminScreenState extends State<SocialHouseAdminScreen> {
  String _searchQuery = "";
  
  @override
  void initState() {
    super.initState();
    Provider.of<SocialHouseAdminProvider>(context, listen: false).loadSocialHouses();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Social Housing Management', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<SocialHouseAdminProvider>(context, listen: false).loadSocialHouses();
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
                    "Social Housing Management Dashboard",
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
      body: Consumer<SocialHouseAdminProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    "Loading social houses...",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Search bar
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    TextField(
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search by title or city',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Stats
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.white,
                child: Row(
                  children: [
                    _buildStatCard(
                      "Total Houses",
                      provider.socialHouses.length.toString(),
                      Icons.home_work,
                      theme.primaryColor,
                    ),
                  ],
                ),
              ),
              
              Divider(height: 1, thickness: 1, color: Colors.grey[200]),
              
              // Social houses list
              Expanded(
                child: provider.socialHouses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_work_outlined,
                              color: Colors.grey[400],
                              size: 48,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "No social houses found",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Add new social houses using the button below",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: provider.socialHouses.length,
                        itemBuilder: (context, index) {
                          final socialHouse = provider.socialHouses[index];
                          
                          // Filter by search query if present
                          if (_searchQuery.isNotEmpty &&
                              !socialHouse.title.toLowerCase().contains(_searchQuery) &&
                              !socialHouse.address.toLowerCase().contains(_searchQuery)) {
                            return SizedBox.shrink();
                          }
                          
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            shadowColor: Colors.black26,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SocialHouseAdminDetails(socialHouse: socialHouse),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Icon at the top
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.home_work,
                                        color: theme.primaryColor,
                                        size: 24,
                                      ),
                                    ),
                                    
                                    Spacer(),
                                    
                                    // Title
                                    Text(
                                      socialHouse.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    
                                    SizedBox(height: 4),
                                    
                                    // Address
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            socialHouse.address,
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
                                    
                                    Spacer(),
                                    
                                    // Delete button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            _showDeleteDialog(context, provider, index);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSocialHouseAdminScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
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
          onTap: () {
            Navigator.pushReplacementNamed(context, AllFlatsAdminScreen.routeName);
          },
        ),
        _buildNavItem(
          context, 
          icon: Icons.home_work,
          label: "Social Housing",
          isActive: true,
          onTap: () {},
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
  
  void _showDeleteDialog(BuildContext context, SocialHouseAdminProvider provider, int index) {
    final socialHouse = provider.socialHouses[index];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Social House'),
        content: Text('Are you sure you want to delete "${socialHouse.title}"?'),
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
              await provider.deleteSocialHouse(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
} 