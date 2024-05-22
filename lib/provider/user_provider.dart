import 'package:flutter/material.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/services/auth.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  bool isLoad = true;
  getDetails() async {
    userModel = await AuthService().getUserDetails();
    isLoad = false;
    notifyListeners();
  }
}
