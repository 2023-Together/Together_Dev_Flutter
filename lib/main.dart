import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';
import 'package:swag_cross_app/router.dart';

void main() async {
  await initializeDateFormatting(); // 달력 언어 한국어 쓰기 위함 local 설정

  // 구글 광고 초기화
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const SWAGCrossApp(),
    ),
  );
}

class SWAGCrossApp extends StatelessWidget {
  const SWAGCrossApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 투명색
        systemNavigationBarColor: Colors.grey.shade200,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp.router(
      routerConfig: router,
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
          // appBar의 아이콘 스타일 지정
          actionsIconTheme: IconThemeData(
            color: Colors.black54,
            size: 34,
          ),
        ),
        primaryColor: const Color(0xFFE9435A),
      ),
      debugShowCheckedModeBanner: false,
      // home: const MainNavigation(initSelectedIndex: 2),
    );
  }
}
