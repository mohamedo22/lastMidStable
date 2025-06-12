import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/home_screen.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/editeProfile/presentation/widgets/customEditeProfileWidget.dart';
import 'package:your_mediator/Features/editeProfile/provider/editeProfileProvider.dart';

class Editeprofilepage extends StatefulWidget {
  static const String routeName = "EditeProfile";
  Editeprofilepage({super.key});

  @override
  State<Editeprofilepage> createState() => _EditeprofilepageState();
}

class _EditeprofilepageState extends State<Editeprofilepage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController username = TextEditingController();
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user?.user;
      if (user != null) {
        setState(() {
          email.text = user.email ?? '';
          phone.text = user.phone ?? '';
          address.text = user.address ?? '';
          username.text = user.username ?? '';
        });
      }
    });
  }
  
  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    address.dispose();
    username.dispose();
    super.dispose();
  }
  
  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text("Profile updated successfully"),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
  
  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var profileProvider = Provider.of<EditProfileProvider>(context);
    
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          "Your Mediator",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: 80, width: 80),
                SizedBox(height: 10),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 24,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Update your personal information",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 10),
                          CustomEditeProfilewidget(
                            icn: Icon(Icons.person, color: theme.primaryColor),
                            txt: "Username",
                            controller: username,
                          ),
                          CustomEditeProfilewidget(
                            icn: Icon(Icons.mail, color: theme.primaryColor),
                            txt: "Email",
                            controller: email,
                          ),
                          CustomEditeProfilewidget(
                            icn: Icon(Icons.phone, color: theme.primaryColor),
                            txt: "Phone",
                            controller: phone,
                          ),
                          CustomEditeProfilewidget(
                            icn: Icon(Icons.location_city, color: theme.primaryColor),
                            txt: "Address",
                            controller: address,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading ? null : () async {
                      // Basic validation
                      if (username.text.isEmpty || email.text.isEmpty || 
                          phone.text.isEmpty || address.text.isEmpty) {
                        _showErrorMessage(context, "All fields are required");
                        return;
                      }
                      
                      // Email validation
                      if (!email.text.contains('@') || !email.text.contains('.')) {
                        _showErrorMessage(context, "Please enter a valid email address");
                        return;
                      }
                      
                      setState(() => isLoading = true);
                      
                      try {
                        await profileProvider.checkData(
                          phone.text, 
                          email.text, 
                          address.text, 
                          username.text
                        );
                        
                        if (profileProvider.model != null) {
                          _showSuccessMessage(context);
                          
                          // Refresh user data
                          await Provider.of<UserProvider>(context, listen: false)
                              .refreshUserData();
                              
                          // Navigate back after a short delay
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                          });
                        } else {
                          _showErrorMessage(context, "Failed to update profile");
                        }
                      } catch (e) {
                        _showErrorMessage(context, "Error: ${e.toString()}");
                      } finally {
                        setState(() => isLoading = false);
                      }
                    },
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Update Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
