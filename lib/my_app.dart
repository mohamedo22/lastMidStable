import 'package:flutter/material.dart';
import 'package:your_mediator/Core/Theme/my_app_theme.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Contact-Us/requests_screen.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/FlatAdmin/flat_admin_page.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Social_housing_admin/SocialHouseAdminScreen.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/home_screen.dart';
import 'package:your_mediator/Features/Home/Peresintation/Pages/social_house_tab.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/login_screen.dart';
import 'package:your_mediator/Features/Login/Presentaion/Page/signupPage.dart';
import 'package:your_mediator/Features/Welcome/splash_screen.dart';
import 'package:your_mediator/Features/Welcome/welcome_screen.dart';
import 'package:your_mediator/Features/editeProfile/presentation/pages/editeProfilePage.dart';
import 'package:your_mediator/Features/userProfile/presentation/pages/userProfile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyAppTheme.myLightThmeme,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        SignUp.routeName: (_) => SignUp(),
        HomeScreen.routeName:(_) => HomeScreen(),
        Editeprofilepage.routeName:(_) => Editeprofilepage(),
        SocialHouseScreen.routeName :(_)=> SocialHouseScreen(),
        Userprofile.routeName :(_)=> Userprofile(),
        Welcome.routeName :(_)=> Welcome(),
        Splash.routeName:(_)=> Splash(),
        AllFlatsAdminScreen.routeName:(_)=> AllFlatsAdminScreen(),
        SocialHouseAdminScreen.routeName :(_) => SocialHouseAdminScreen(),
        RequestsScreen.routeName :(_)=> RequestsScreen(),
        },

      initialRoute: Splash.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
