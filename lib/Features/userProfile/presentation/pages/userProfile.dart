import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/editeProfile/presentation/pages/editeProfilePage.dart';
import 'package:your_mediator/Features/userProfile/presentation/widgets/customUserProfileWidget.dart';
import 'package:intl/intl.dart'; // Add this for date formatting

class Userprofile extends StatelessWidget {
  const Userprofile({super.key});

  static const String routeName = "User profile";

  String _formatBirthDate(String? isoDate) {
    if (isoDate == null) return 'N/A';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user?.user;

    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Your Mediator",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/logo.png', height: 100),
              const SizedBox(height: 10),
              const Text(
                "User Profile",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Customuserprofilewidget(
                        icon: Icons.person,
                        title: "Username",
                        value: user?.username ?? 'N/A',
                      ),
                      const Divider(),
                      Customuserprofilewidget(
                        icon: Icons.phone,
                        title: "Phone",
                        value: user?.phone ?? 'N/A',
                      ),
                      const Divider(),
                      Customuserprofilewidget(
                        icon: Icons.mail,
                        title: "E-mail",
                        value: user?.email ?? 'N/A',
                      ),
                      const Divider(),
                      Customuserprofilewidget(
                        icon: Icons.location_city,
                        title: "Address",
                        value: user?.address ?? 'N/A',
                      ),
                      const Divider(),
                      Customuserprofilewidget(
                        icon: Icons.cake,
                        title: "Birth Date",
                        value: _formatBirthDate(user?.birthDate),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Editeprofilepage.routeName);
                },
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}