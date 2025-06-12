import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/login_screen.dart';
import 'package:your_mediator/Features/Login/Presentaion/widgets/customFormField.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';

class SignUp extends StatelessWidget {
  static const String routeName = "/signup";
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _nationalIdController = TextEditingController();
    final TextEditingController _birthdateController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _locationController = TextEditingController();
    final theme = Theme.of(context);
    
    final userProvider = Provider.of<UserProvider>(context);

    // Success dialog with animated elements
    void showSuccessDialog(String message) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text("Success", style: TextStyle(color: Colors.green)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                backgroundColor: Colors.green.withOpacity(0.1),
                radius: 40,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 50,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Continue to Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Enhanced error dialog
    void showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 28),
              SizedBox(width: 10),
              Text("Sign Up Failed", style: TextStyle(color: Colors.red)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Please check your information and try again.",
                        style: TextStyle(color: Colors.red[800], fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.primaryColor,
                  theme.primaryColor.withOpacity(0.8),
                  theme.primaryColor.withOpacity(0.6),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                // App Logo and Title
                Text(
                  "Your Mediator",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 0.5,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.03),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight * 0.03),
                            // Register Header
                            Row(
                              children: [
                                Icon(
                                  Icons.app_registration_rounded,
                                  color: theme.primaryColor,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Please fill the information below to create your account",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // App Logo
                            Image.asset(
                              "assets/images/logo.png",
                              width: screenWidth * 0.25,
                              height: screenHeight * 0.1,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Registration Form
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Personal Information Section
                                    _buildSectionTitle(context, "Personal Information"),
                                    
                                    _buildFormLabel(context, "Username"),
                                    CustomFormField(
                                      icn: Icon(Icons.person, color: theme.primaryColor),
                                      txt: "Enter your username",
                                      controller: _usernameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your username";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    
                                    _buildFormLabel(context, "National ID"),
                                    CustomFormField(
                                      icn: Icon(Icons.credit_card, color: theme.primaryColor),
                                      txt: "Enter your national ID",
                                      controller: _nationalIdController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your national ID";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    
                                    _buildFormLabel(context, "Birthdate"),
                                    CustomFormField(
                                      icn: Icon(Icons.calendar_today, color: theme.primaryColor),
                                      txt: "YYYY-MM-DD",
                                      controller: _birthdateController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your birthdate";
                                        }
                                        if (DateTime.tryParse(value) == null) {
                                          return "Invalid date format";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    
                                    // Contact Information Section
                                    _buildSectionTitle(context, "Contact Information"),
                                    
                                    _buildFormLabel(context, "Phone Number"),
                                    CustomFormField(
                                      icn: Icon(Icons.phone, color: theme.primaryColor),
                                      txt: "Enter your phone number",
                                      controller: _phoneController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your phone number";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    
                                    _buildFormLabel(context, "Email"),
                                    CustomFormField(
                                      icn: Icon(Icons.email, color: theme.primaryColor),
                                      txt: "Enter your email",
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your email";
                                        }
                                        if (!value.contains('@') || !value.contains('.')) {
                                          return "Please enter a valid email";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    
                                    // Security Section
                                    _buildSectionTitle(context, "Security"),
                                    
                                    _buildFormLabel(context, "Password"),
                                    CustomFormField(
                                      icn: Icon(Icons.lock, color: theme.primaryColor),
                                      txt: "Create a strong password",
                                      isPassword: true,
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your password";
                                        }
                                        if (value.length < 6) {
                                          return "Password must be at least 6 characters";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    
                                    _buildFormLabel(context, "Location"),
                                    CustomFormField(
                                      icn: Icon(Icons.location_on, color: theme.primaryColor),
                                      txt: "Enter your location",
                                      controller: _locationController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your location";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            // Register Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: userProvider.loading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          // Parse the birthdate.
                                          DateTime? birthDate = DateTime.tryParse(
                                              _birthdateController.text);
                                          if (birthDate == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Invalid birthdate format')));
                                            return;
                                          }

                                          await userProvider.signup(
                                            username: _usernameController.text,
                                            nationalId: _nationalIdController.text,
                                            birthDate: birthDate,
                                            phone: _phoneController.text,
                                            password: _passwordController.text,
                                            email: _emailController.text,
                                            address: _locationController.text,
                                          );

                                          if (userProvider.user?.stat == true) {
                                            showSuccessDialog("Your account has been created successfully!");
                                          } else {
                                            showErrorDialog(userProvider.user?.message ??
                                                "Sign up failed");
                                          }
                                        }
                                      },
                                child: userProvider.loading
                                    ? SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        "REGISTER",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Login Option
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, LoginScreen.routeName);
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // Helper widget for section titles
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 15),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 4,
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
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper widget for form labels
  Widget _buildFormLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
          fontSize: 14,
        ),
      ),
    );
  }
}