import 'package:flutter/cupertino.dart';
import 'package:your_mediator/Features/editeProfile/Model/editProfile.dart';
import 'package:your_mediator/Features/editeProfile/controller/editeProfileServices.dart';

class EditProfileProvider extends ChangeNotifier{
  EditeProfileModel? model;
  checkData(phone, email, address, userName)async{
    model = await EditProfileServices.editeData(phone, userName, email, address);
    notifyListeners();
  }
}