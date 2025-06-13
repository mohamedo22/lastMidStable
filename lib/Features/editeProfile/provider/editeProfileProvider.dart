import 'package:flutter/cupertino.dart';
import 'package:your_mediator/Features/Login/Provider/user_provider.dart';
import 'package:your_mediator/Features/editeProfile/Model/editProfile.dart';
import 'package:your_mediator/Features/editeProfile/controller/editeProfileServices.dart';

class EditProfileProvider extends ChangeNotifier{
  EditeProfileModel? model;
  checkData(userID,phone, email, address, userName)async{
    model = await EditProfileServices.editeData(userID,phone, userName, email, address);
    notifyListeners();
    await UserProvider().refreshUserData();
  }
}