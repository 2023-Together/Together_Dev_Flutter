import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/models/DBModels/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogined = false;
  UserModel? _userData;

  bool get isLogined => _isLogined;
  UserModel? get userData => _userData;

  void login(UserModel userData) {
    _isLogined = true;
    _userData = userData;
    notifyListeners();
  }

  void testLogin() {
    _isLogined = true;
    notifyListeners();
  }

  void logout() {
    _isLogined = false;
    _userData = null;
    notifyListeners();
  }

  void updateUserData(UserModel userData) {
    _userData = userData;
    notifyListeners();
  }

  void loginCheckIsNone(BuildContext context) {
    if (_isLogined) {
      _isLogined = false;

      swagPlatformDialog(
        context: context,
        title: "로그인 알림",
        message: "로그인을 해야만 사용할 수 있는 기능입니다! 로그인 창으로 이동하시겠습니까?",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("아니오"),
          ),
          TextButton(
            onPressed: () => context.goNamed(SignInScreen.routeName),
            child: const Text("예"),
          ),
        ],
      );
    }
  }
}
