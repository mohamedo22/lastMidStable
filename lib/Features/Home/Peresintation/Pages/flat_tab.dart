import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:your_mediator/Features/Details/presentation/flatDetailsPage.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/social_house_tab.dart';
import 'package:your_mediator/Features/Home/Peresintation/Providers/flat_provider.dart';
import 'package:your_mediator/Features/Home/model/flat_model.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = "/home-tab";
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isFiltered = false;
  late TabController _filterTabController;
  
  // Filter options
  final List<String> _filterOptions = ["All", "Price Low", "Price High", "Newest"];
  int _selectedFilterIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _filterTabController = TabController(length: _filterOptions.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FlatProvider>(context, listen: false).loadFlats();
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _filterTabController.dispose();
    super.dispose();
  }
  
  // Filter flats based on search query
  List<Flatt> _filterFlats(List<Flatt> flats) {
    if (_searchQuery.isEmpty) {
      return flats;
    }
    
    return flats.where((flat) {
      final address = flat.address.toLowerCase();
      final price = flat.price.toString();
      final bedrooms = flat.bedrooms.toString();
      final query = _searchQuery.toLowerCase();
      
      return address.contains(query) || 
             price.contains(query) || 
             bedrooms.contains(query);
    }).toList();
  }
  
  // Sort flats based on selected filter
  List<Flatt> _sortFlats(List<Flatt> flats) {
    switch (_selectedFilterIndex) {
      case 1: // Price Low
        return List.from(flats)..sort((a, b) => a.price.compareTo(b.price));
      case 2: // Price High
        return List.from(flats)..sort((a, b) => b.price.compareTo(a.price));
      case 3: // Newest (using flatCode as proxy for date)
        return List.from(flats)..sort((a, b) => b.flatCode.compareTo(a.flatCode));
      default: // All (default order)
        return flats;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      color: Colors.grey[100],
      child: Consumer<FlatProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (provider.flats.isEmpty) {
            return _buildEmptyState();
          }

          // Apply filtering and sorting
          final filteredFlats = _filterFlats(provider.flats);
          final sortedFlats = _sortFlats(filteredFlats);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search & Filter UI
              _buildSearchAndFilter(),
              
              // Filter tabs
              _buildFilterTabs(),
              
              // Results count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${sortedFlats.length} Properties Found",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontSize: 15

                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFiltered = !_isFiltered;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            _isFiltered ? Icons.grid_view : Icons.view_list,
                            size: 20,
                            color: theme.primaryColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            _isFiltered ? "Grid View" : "List View",
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Property listings
              Expanded(
                child: _isFiltered
                    ? _buildGridView(sortedFlats)
                    : _buildListView(sortedFlats),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search properties by location, price...',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = "";
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          SizedBox(height: 10),
          _buildCategories(),
        ],
      ),
    );
  }
  
  Widget _buildCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCategoryButton('Flats', context, "https://i.postimg.cc/L824Zsb9/apartment.png", true),
        _buildCategoryButton('Social Housing', context, "https://i.postimg.cc/3RKw5x2f/social-housing.png", false),
      ],
    );
  }
  
  Widget _buildCategoryButton(String label, BuildContext context, String image, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacementNamed(context, SocialHouseScreen.routeName);
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected 
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Image.network(
              image,
              width: 30,
              height: 30,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: TabBar(
        controller: _filterTabController,
        onTap: (index) {
          setState(() {
            _selectedFilterIndex = index;
          });
        },
        isScrollable: true,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        indicatorColor: Theme.of(context).primaryColor,
        indicatorWeight: 3,
        tabs: _filterOptions.map((option) => Tab(text: option)).toList(),
      ),
    );
  }
  
  Widget _buildGridView(List<Flatt> flats) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: flats.length,
      itemBuilder: (context, index) {
        final flat = flats[index];
        return _buildGridCard(
          flat.address,
          '${flat.price} L.E',
          '${flat.bedrooms} BD | ${flat.bathrooms} BA',
          flat.images.isNotEmpty ? flat.images[0] : '',
          flat,
        );
      },
    );
  }
  
  Widget _buildListView(List<Flatt> flats) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: flats.length,
      itemBuilder: (context, index) {
        final flat = flats[index];
        return _buildListCard(
          flat.address,
          '${flat.price} L.E',
          '${flat.bedrooms} Bedrooms | ${flat.bathrooms} Bathrooms',
          flat.images.isNotEmpty ? flat.images[0] : '',
          flat,
        );
      },
    );
  }
  
  Widget _buildGridCard(
    String location,
    String price,
    String details,
    String imagePath,
    Flatt flat,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detailspage(
              flatCode: flat.flatCode,
              price: flat.price,
              bathrooms: flat.bathrooms,
              bedrooms: flat.bedrooms,
              floorNumber: flat.floorNumber,
              governorate: flat.governorate,
              city: flat.city,
              details: flat.details,
              address: flat.address,
              images: flat.images,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: buildImageGrid(imagePath),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  // Location
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  // Details
                  Text(
                    details,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildListCard(
    String location,
    String price,
    String details,
    String imagePath,
    Flatt flat,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detailspage(
                flatCode: flat.flatCode,
                price: flat.price,
                bathrooms: flat.bathrooms,
                bedrooms: flat.bedrooms,
                floorNumber: flat.floorNumber,
                governorate: flat.governorate,
                city: flat.city,
                details: flat.details,
                address: flat.address,
                images: flat.images,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: buildImage(imagePath),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Location
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    // Details
                    Row(
                      children: [
                        Icon(Icons.bed, size: 18, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '${flat.bedrooms} Bed',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.bathtub, size: 18, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '${flat.bathrooms} Bath',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home_work_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            "No Properties Found",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "We couldn't find any properties matching your criteria",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<FlatProvider>(context, listen: false).loadFlats();
            },
            icon: Icon(Icons.refresh),
            label: Text("Refresh"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
        return Image.memory(bytes, width: 150, height: 130, fit: BoxFit.cover);
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
  Widget buildImageGrid(String imgPath) {
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
        return Image.memory(bytes, width: 150, height: 100, fit: BoxFit.cover);
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

  Widget getImageWidget(String imagePath, {required double height, required double width}) {
    if (imagePath.isEmpty) {
      return Container(
        height: height,
        width: width,
        color: Colors.grey[300],
        child: Icon(Icons.home, color: Colors.grey[400], size: 40),
      );
    }

    try {
      if (imagePath.startsWith('http')) {
        return CachedNetworkImage(
          imageUrl: imagePath,
          fit: BoxFit.cover,
          height: height,
          width: width,
          placeholder: (context, url) => Container(
            height: height,
            width: width,
            color: Colors.grey[200],
            child: Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            height: height,
            width: width,
            color: Colors.grey[300],
            child: Icon(Icons.error, color: Colors.red),
          ),
        );
      } else {
        // Handle base64 images or other formats
        try {
          return Image.memory(
            base64Decode(imagePath),
            fit: BoxFit.cover,
            height: height,
            width: width,
          );
        } catch (e) {
          return Container(
            height: height,
            width: width,
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.grey[500]),
          );
        }
      }
    } catch (e) {
      return Container(
        height: height,
        width: width,
        color: Colors.grey[300],
        child: Icon(Icons.error, color: Colors.red),
      );
    }
  }
}
