import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swag_cross_app/features/main/main_page.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_main.dart';
import 'package:swag_cross_app/features/storages/methods/show_platform_dialog.dart';

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
    return loginType;
  }

  // 로그인이 되어있지 않은데 메인에 있을때 실행하는 메소드
  static Future loginCheckIsNone(BuildContext context, bool mounted) async {
    var loginType = await storage.read(key: _keyValue);
    if (!mounted) return;
    if (loginType == "none") {
      showPlatformDialog(
        context: context,
        title: "계정 오류",
        message: "현재 로그인 상태가 아닙니다!",
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const SignInMain(),
                ),
                (route) => false),
            child: const Text("확인"),
          ),
        ],
      );
    }
  }

  // 로그인이 되어있는데 로그인 창에 있을때 실행하는 메소드
  static Future loginCheckIsSNS(BuildContext context) async {
    var loginType = await storage.read(key: _keyValue);
    if (loginType != "none") {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
        (route) => false,
      );
    }
  }
}