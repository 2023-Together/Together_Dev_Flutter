import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogined = false;
  String? _loginType;

  bool get isLogined => _isLogined;
  String get loginType => _loginType!;

  void login(String type) {
    _isLogined = true;
    _loginType = type;
    notifyListeners();
  }

  void logout() {
    _isLogined = false;
    _loginType = null;
    notifyListeners();
  }

  void loginCheckIsNone(BuildContext context) {
    if (_loginType != "naver" || _loginType != "kakao") {
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
