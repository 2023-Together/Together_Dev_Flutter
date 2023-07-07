import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_main.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';

class SecureStorageLogin {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const _keyValue = "loginType";

  // 로그인타입을 수정하는 메소드
  static Future saveLoginType(String str) async {
    await storage.write(key: _keyValue, value: str);
  }

  // 로그인타입을 리턴하는 메소드
  static Future getLoginType() async {
    var loginType = await storage.read(key: _keyValue);
    return loginType.toString();
  }

  // 로그아웃 하는 메소드
  static Future setLogout() async {
    await storage.write(key: _keyValue, value: "none");
  }

  // 로그인이 되어있지 않은데 메인에 있을때 실행하는 메소드
  static Future loginCheckIsNone(BuildContext context, bool mounted) async {
    var loginType = await storage.read(key: _keyValue);
    // 메소드에서 context를 사용할때 무조건 선언!
    if (!mounted) return;
    if (loginType != "naver" || loginType != "kakao") {
      await storage.write(key: _keyValue, value: "none");
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
            onPressed: () => context.goNamed(SignInMain.routeName),
            child: const Text("확인"),
          ),
        ],
      );
    }
  }

  // 로그인이 되어있는데 로그인 창에 있을때 실행하는 메소드
  static Future loginCheckIsSNS(BuildContext context, bool mounted) async {
    var loginType = await storage.read(key: _keyValue);
    // 메소드에서 context를 사용할때 무조건 선언!
    if (!mounted) return;
    if (loginType == "naver" || loginType == "kakao") {
      context.goNamed(MainNavigation.routeName);
    }
  }
}
