
import 'package:eventlyapproute/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser? currentUser;

  void changeUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }
}