import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/home_screen.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/Welcome/welcome_screen.dart';


class Splash extends StatelessWidget {
  static const String routeName = "/splash";
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      var user =Provider.of<UserProvider>(context,listen: false);
      if(user.user ==null){
        Navigator.pushReplacementNamed(context, Welcome.routeName);
      }else{
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }


    });
    return Image.asset(
      "assets/images/splash.png",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }
}
