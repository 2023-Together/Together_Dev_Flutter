import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const _keyLoginData = "loginData";

  static Future saveLoginData({required String email}) async {
    await storage.write(key: _keyLoginData, value: email);
  }

  static Future<String?> getLoginData() async {
    return await storage.read(key: _keyLoginData);
  }

  // 이메일을 비움
  static Future resetLoginData() async {
    await storage.delete(key: _keyLoginData);
  }
}
