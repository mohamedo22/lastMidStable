import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Admin/Presentation/Providers/SocialHouseAdminProvider.dart';
import 'package:your_mediator/Features/Admin/Presentation/Providers/flat_admin_provider.dart';
import 'package:your_mediator/Features/Admin/Presentation/Providers/request_provider.dart';
import 'package:your_mediator/Features/Home/Peresintation/Providers/flat_provider.dart';
import 'package:your_mediator/Features/Home/Peresintation/Providers/social_house_provider.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/addFlat/presentation/Providers/flat_provider.dart';
import 'package:your_mediator/Features/contactUs/provider/contact_us_provider.dart';
import 'package:your_mediator/Features/editeProfile/provider/editeProfileProvider.dart';
import 'package:your_mediator/my_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider(),),
      ChangeNotifierProvider(create: (context) => FlatProvider(),),
      ChangeNotifierProvider(create: (context) => SocialHouseProvider(),),
      ChangeNotifierProvider(create: (context) => EditProfileProvider(),),
      ChangeNotifierProvider(create: (context) => ContactUsProvider(),),
      ChangeNotifierProvider(create: (context) => FlatAdminProvider(),),
      ChangeNotifierProvider(create: (context) => SocialHouseAdminProvider(),),
      ChangeNotifierProvider(create: (context) => RequestProvider(),),
      ChangeNotifierProvider(create: (context) => AddFlatProvider(),)
    ],
    child: const MyApp()));
}