import 'package:chotot_app/src/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  // MARK: getter & setter
  UserModel? get getUser => _user;
  set setUser(UserModel user) {
    _user = user;
  }
}

UserProvider userProvider = UserProvider();
