import 'package:flutter/material.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/login_screen.dart';

class Welcome extends StatelessWidget {
  static const String routeName = "/welcome";
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset("assets/images/welcomeLogo.png"),
        const SizedBox(
          width: double.infinity,
        ),
        Text(
          "In our application \n your selling , buying and \n renting process will be  \n easier and more secure.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text(
              "Be part of our community",
            )),
      ]),
    );
  }
}
