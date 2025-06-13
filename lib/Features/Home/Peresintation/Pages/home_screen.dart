import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/flat_tab.dart';
import 'package:your_mediator/Features/Settings/Presentation/Page/SettingsPage.dart';
import 'package:your_mediator/Features/addFlat/presentation/pages/addFlatTap.dart';
import 'package:your_mediator/Features/contactUs/presentation/pages/contctUs.dart';
import 'package:your_mediator/Features/userProfile/presentation/pages/userProfile.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    AddFlatTab(),
    SettingsTab(),
  ];
  
  final List<String> tabTitles = [
    "Home",
    "Add Flat",
    "Settings"
  ];
  
  late AnimationController _animationController;
  bool _isDrawerOpen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      if (_isDrawerOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          tabTitles[selectedIndex],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.3),
              child: IconButton(
                icon: Icon(Icons.person,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Userprofile.routeName);
                },
              ),
            ),
          )
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          _buildWelcomeHeader(),
          Expanded(child: tabs[selectedIndex]),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: theme.primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "Add Flat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),

    );
  }
  
  Widget _buildWelcomeHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Find your perfect property",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  "Egypt",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawer(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: theme.primaryColor),
                ),
                SizedBox(height: 10),
                Text(
                  "Your Mediator",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Find your perfect home",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home_rounded,
            title: "Home",
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
              Navigator.pop(context);
            },
            isSelected: selectedIndex == 0,
          ),
          _buildDrawerItem(
            icon: Icons.add_circle_outline,
            title: "Add Flat",
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
              Navigator.pop(context);
            },
            isSelected: selectedIndex == 1,
          ),
          _buildDrawerItem(
            icon: Icons.person_outline,
            title: "My Profile",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Userprofile.routeName);
            },
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
              Navigator.pop(context);
            },
            isSelected: selectedIndex == 2,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      tileColor: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
  
  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search Properties",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              SizedBox(height: 20),
              _buildSearchField(),
              SizedBox(height: 20),
              Text(
                "Filter By",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildFilterOptions(),
              SizedBox(height: 20),
              Text(
                "Price Range",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildPriceRangeSlider(),
              SizedBox(height: 20),
              Text(
                "Property Features",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildFeatureCheckboxes(),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // Implement search functionality
                  },
                  child: Text(
                    "SEARCH",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by location, price, features...',
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
  
  Widget _buildFilterOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFilterOption(icon: Icons.apartment, label: "Flat"),
        _buildFilterOption(icon: Icons.house, label: "House"),
        _buildFilterOption(icon: Icons.villa, label: "Villa"),
        _buildFilterOption(icon: Icons.home_work, label: "Social Housing"),
      ],
    );
  }
  
  Widget _buildFilterOption({required IconData icon, required String label}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
  
  Widget _buildPriceRangeSlider() {
    RangeValues _currentRangeValues = RangeValues(1000, 5000);
    
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 10000,
              divisions: 100,
              activeColor: Theme.of(context).primaryColor,
              labels: RangeLabels(
                '${_currentRangeValues.start.round()} LE',
                '${_currentRangeValues.end.round()} LE',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_currentRangeValues.start.round()} LE'),
                Text('${_currentRangeValues.end.round()} LE'),
              ],
            ),
          ],
        );
      }
    );
  }
  
  Widget _buildFeatureCheckboxes() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildFeatureChip("1+ Bedroom"),
        _buildFeatureChip("2+ Bathrooms"),
        _buildFeatureChip("Garage"),
        _buildFeatureChip("Garden"),
        _buildFeatureChip("Balcony"),
        _buildFeatureChip("Furnished"),
      ],
    );
  }
  
  Widget _buildFeatureChip(String label) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isSelected = false;
        
        return FilterChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              isSelected = selected;
            });
          },
          selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
          checkmarkColor: Theme.of(context).primaryColor,
        );
      }
    );
  }
}