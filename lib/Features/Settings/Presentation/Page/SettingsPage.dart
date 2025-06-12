import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/login_screen.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/Settings/Presentation/Widgets/CustomSettingsCard.dart';
import 'package:your_mediator/Features/userProfile/presentation/pages/userProfile.dart';

class SettingsTab extends StatelessWidget {
  static const String routeName = "Settings";
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Header Container
          _buildSettingsHeader(context),
          
          // Settings Options
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Settings Section
                  _buildSectionHeader(context, "Account Settings"),
                  
                  _buildSettingsCard(
                    context,
                    icon: Icons.person_outline,
                    title: "Personal Profile",
                    subtitle: "View and edit your personal information",
                    iconBgColor: Colors.blue[100]!,
                    iconColor: Colors.blue,
                    trailing: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.pushNamed(context, Userprofile.routeName);
                    },
                  ),
                  
                  _buildSettingsCard(
                    context,
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    subtitle: "Update your account password",
                    iconBgColor: Colors.purple[100]!,
                    iconColor: Colors.purple,
                    trailing: Icons.arrow_forward_ios,
                    onTap: () {
                      _showChangePasswordDialog(context);
                    },
                  ),
                  
                  // App Settings Section
                  _buildSectionHeader(context, "App Settings"),
                  
                  _buildSettingsToggleCard(
                    context,
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    subtitle: "Manage your notification preferences",
                    iconBgColor: Colors.orange[100]!,
                    iconColor: Colors.orange,
                    value: true,
                    onChanged: (value) {},
                  ),
                  
                  _buildSettingsToggleCard(
                    context,
                    icon: Icons.data_saver_off,
                    title: "Data Saver",
                    subtitle: "Reduce data usage in the app",
                    iconBgColor: Colors.green[100]!,
                    iconColor: Colors.green,
                    value: false,
                    onChanged: (value) {},
                  ),
                  
                  // Privacy & Legal Section
                  _buildSectionHeader(context, "Privacy & Legal"),
                  
                  _buildSettingsCard(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    subtitle: "Read our privacy policy",
                    iconBgColor: Colors.red[100]!,
                    iconColor: Colors.red,
                    trailing: Icons.arrow_forward_ios,
                    onTap: () {
                      // Navigate to privacy policy
                    },
                  ),
                  
                  _buildSettingsCard(
                    context,
                    icon: Icons.description_outlined,
                    title: "Terms of Service",
                    subtitle: "Read our terms of service",
                    iconBgColor: Colors.teal[100]!,
                    iconColor: Colors.teal,
                    trailing: Icons.arrow_forward_ios,
                    onTap: () {
                      // Navigate to terms of service
                    },
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Logout Button
                  _buildLogoutButton(context, userProvider),
                  
                  SizedBox(height: 20),
                  
                  // App Version
                  Center(
                    child: Text(
                      "App Version 1.0.0",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingsHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Mediator",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingsCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBgColor,
    required Color iconColor,
    required IconData trailing,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          trailing,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }
  
  Widget _buildSettingsToggleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBgColor,
    required Color iconColor,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
        secondary: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        value: value,
        activeColor: Theme.of(context).primaryColor,
        onChanged: onChanged,
      ),
    );
  }
  
  Widget _buildLogoutButton(BuildContext context, UserProvider userProvider) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton.icon(
        icon: Icon(Icons.logout),
        label: Text(
          "LOGOUT",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          _showLogoutConfirmationDialog(context, userProvider);
        },
      ),
    );
  }
  
  void _showLogoutConfirmationDialog(BuildContext context, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 10),
            Text("Logout", style: TextStyle(color: Colors.red)),
          ],
        ),
        content: Text("Are you sure you want to logout from your account?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              userProvider.logout();
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: Text(
              "LOGOUT",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController _currentPasswordController = TextEditingController();
    final TextEditingController _newPasswordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.lock_outline, color: Theme.of(context).primaryColor),
            SizedBox(width: 10),
            Text("Change Password"),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: "Current Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 15),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 15),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              // Validate and update password
              if (_newPasswordController.text == _confirmPasswordController.text) {
                // Update password logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Password updated successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Passwords do not match"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(
              "UPDATE",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
