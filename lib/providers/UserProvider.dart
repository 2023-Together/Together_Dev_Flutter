import 'package:flutter/material.dart';
import 'package:swag_cross_app/models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogin = false;
  // 타입 뒤에 ?는 null값을 허용한다는 의미
  UserModel? _userModel;

  bool get isLogin => _isLogin;
  UserModel get userModel => _userModel!;

  void login(UserModel userModel) {
    _isLogin = true;
    _userModel = userModel;
    notifyListeners();
  }

  void logout() {
    _isLogin = false;
    _userModel = null;
    notifyListeners();
  }
}
