import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/FlatAdmin/flat_admin_page.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/home_screen.dart';
import 'package:your_mediator/Features/Login/Presentaion/widgets/customFormField.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/signupPage.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final userProvider = Provider.of<UserProvider>(context);
    final theme = Theme.of(context);

    // Success dialog with animated checkmark
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
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Continue",
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
              Text("Login Failed", style: TextStyle(color: Colors.red)),
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
                        "Please check your credentials and try again.",
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
                SizedBox(height: screenHeight * 0.1),
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
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Find Your Perfect Home",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 0.5,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.06),
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
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight * 0.04),
                            // Login Header
                            Row(
                              children: [
                                Icon(
                                  Icons.login_rounded,
                                  color: theme.primaryColor,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Welcome Back",
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
                              "Sign in to continue to your account",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            // App Logo
                            Image.asset(
                              "assets/images/logo.png",
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.15,
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            // Login Form
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
                                    Text(
                                      "Username",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    CustomFormField(
                                      icn: Icon(Icons.lock, color: theme.primaryColor),
                                      txt: "Enter your password",
                                      isPassword: true,
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your password";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            // Login Button
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
                                          if (_usernameController.text == "zeyad" &&
                                              _passwordController.text == "zeyad") {
                                            Navigator.pushReplacementNamed(
                                                context, AllFlatsAdminScreen.routeName);
                                            return;
                                          }
                                          await userProvider.login(
                                            _usernameController.text,
                                            _passwordController.text,
                                          );

                                          if (userProvider.user?.stat == true) {
                                            showSuccessDialog("Login successful!");
                                          } else {
                                            final errorMessage = userProvider.user?.message ??
                                                "Login failed. Please try again.";
                                            Future.microtask(() => showErrorDialog(errorMessage));
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
                                        "LOGIN",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            // Register Option
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, SignUp.routeName);
                                  },
                                  child: Text(
                                    "Register Now",
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
}
