
// Updated UI (contact_us.dart)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/home_screen.dart';
import 'package:your_mediator/Features/contactUs/Model/contact_us_model.dart';
import 'package:your_mediator/Features/contactUs/provider/contact_us_provider.dart';

import '../widgets/customContactTextWidget.dart';
import '../widgets/customContactWidget.dart';

class ContctUsScreen extends StatelessWidget {
  static const String routeName = "contactus";

  final String userName;
  final String email;
  final String phone;
  final int flatCode;
  final int userId;


  ContctUsScreen({
    super.key,
    required this.phone,
    required this.email,
    required this.flatCode,
    required this.userName,
    required this.userId,

  });

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactUsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 10),
                const Text(
                  "Contact us",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey[100],
                    ),
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Customcontacttextwidget(text: "UserName : $userName", icon: Icons.person),
                          const SizedBox(height: 10),
                          Customcontacttextwidget(text: "Phone : $phone", icon: Icons.phone),
                          const SizedBox(height: 10),
                          Customcontacttextwidget(text: "Email : $email", icon: Icons.email),
                          const SizedBox(height: 10),
                          Customcontacttextwidget(text: "Flat code : $flatCode", icon: Icons.code),
                          const SizedBox(height: 10),
                          Customcontactwidget(icn: const Icon(Icons.date_range), txt: "Date of evaluation", controller: dateController),
                          const SizedBox(height: 10),
                          Customcontactwidget(icn: const Icon(Icons.timelapse), txt: "Time of evaluation", controller: timeController),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
                  ),
                  onPressed: contactProvider.isLoading
                      ? null
                      : () {
                    final request = ContactUsRequest(
                      userId: userId,
                       flatCode: flatCode,
                      date: dateController.text,
                      time: timeController.text,
                    );
                    contactProvider.submitRequest(request, context);
                    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  },
                  child: contactProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Contact us", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
