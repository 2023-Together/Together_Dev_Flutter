import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main_page/main_page.dart';

void main() async {
  await initializeDateFormatting(); // 달력 언어 한국어 쓰기 위함 local 설정
  runApp(const SWAGCrossApp());
}

class SWAGCrossApp extends StatelessWidget {
  const SWAGCrossApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
