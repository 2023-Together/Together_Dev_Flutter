import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/models/DBModels/user_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

import 'package:http/http.dart' as http;

class LogoLoadingScreen extends StatefulWidget {
  static const routeName = "loading";
  static const routeURL = "/";
  const LogoLoadingScreen({super.key});

  @override
  State<LogoLoadingScreen> createState() => _LogoLoadingScreenState();
}

class _LogoLoadingScreenState extends State<LogoLoadingScreen> {
  Timer? _timer; // Timer 변수 선언

  @override
  void initState() {
    super.initState();

    _checkAutoLogined();

    if (_timer != null) {
      _timer!.cancel(); // 이전 타이머 취소
    }
    _timer = Timer(const Duration(milliseconds: 500), () {
      context.goNamed(MainNavigation.routeName);
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 타이머 취소
    super.dispose();
  }

  void _checkAutoLogined() async {
    final String? loginData = await LoginStorage.getLoginData();
    print(loginData);

    if (loginData == null) return;
    if (loginData.trim().isNotEmpty) {
      final url = Uri.parse("${HttpIp.userUrl}/together/login");
      // final headers = {'Content-Type': 'application/json'};
      final data = {"userEmail": loginData};

      final response = await http.post(url, body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (!mounted) return;
        context
            .read<UserProvider>()
            .autoLogin(UserModel.fromJson(jsonResponse));
        context.pop();
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "자동 로그인 실패!",
          message: "${response.statusCode.toString()} : ${response.body}",
        );
      }

      if (!mounted) return;
      context.goNamed(MainNavigation.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "함께해요 Together!",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
