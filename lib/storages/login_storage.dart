import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const _keyLoginData = "loginData";

  static Future saveLoginData({required String id, required String pw}) async {
    await storage.write(key: _keyLoginData, value: "$id,$pw");
  }

  static Future<String?> getLoginData() async {
    return await storage.read(key: _keyLoginData);
  }

  // 아이디, 비밀번호를 비움
  static Future resetLoginData() async {
    await storage.write(key: _keyLoginData, value: "");
  }
}
