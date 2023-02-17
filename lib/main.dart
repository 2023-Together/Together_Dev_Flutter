import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/sign_in_out/sign_in_main.dart';

void main() {
  runApp(const SWAGCrossApp());
}

class SWAGCrossApp extends StatelessWidget {
  const SWAGCrossApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swag Cross App',
      theme: ThemeData(
        // 모든 하위 Scaffold에 배경색을 지정해 준다.
        scaffoldBackgroundColor: Colors.white,
        // appBar의 공통 스타일을 지정해준다.
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          // title의 공통 스타일을 지정해준다.
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        primaryColor: const Color(0xFFE9435A),
      ),
      home: const SignInMain(),
    );
  }
}