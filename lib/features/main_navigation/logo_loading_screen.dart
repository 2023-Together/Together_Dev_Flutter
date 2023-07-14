import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

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
      List<String> userData = loginData.split(",");

      final id = userData[0];
      final pw = userData[1];

      if (!mounted) return;
      context.read<UserProvider>().login("naver");

      context.goNamed(MainNavigation.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "함께해요 Together!",
          style: context.textTheme.displayMedium,
        ),
      ),
    );
  }
}
