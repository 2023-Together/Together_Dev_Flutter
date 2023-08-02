import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/providers/current_post_provider.dart';
import 'package:swag_cross_app/providers/main_navigation_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
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
        ChangeNotifierProvider(create: (_) => MainNavigationProvider()),
        ChangeNotifierProvider(create: (_) => CurrentPostProvider()),
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

        // Text
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: Sizes.size28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontSize: Sizes.size26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          // 제목 글자
          titleLarge: TextStyle(
            fontSize: Sizes.size20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          // 회색 글자
          labelLarge: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.normal,
            color: Colors.black45,
          ),
          labelMedium: TextStyle(
            fontSize: Sizes.size14,
            fontWeight: FontWeight.normal,
            color: Colors.black45,
          ),
          labelSmall: TextStyle(
            fontSize: Sizes.size12,
            fontWeight: FontWeight.normal,
            color: Colors.black45,
          ),
          // 일반 글자
          bodyLarge: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: TextStyle(
            fontSize: Sizes.size14,
            fontWeight: FontWeight.normal,
          ),
        ),

        // ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade300,
          ),
        ),

        // ListTile
        listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
          subtitleTextStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: Sizes.size14,
          ),
          iconColor: Colors.black54,
        ),

        // ExpansionTile
        expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.black54,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          // title의 공통 스타일을 지정해준다.
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
          // appBar의 아이콘 스타일 지정
          actionsIconTheme: IconThemeData(
            color: Colors.black54,
            size: 38,
          ),
        ),
        primaryColor: const Color(0xFFE9435A),
      ),
      debugShowCheckedModeBanner: false,
      // home: const MainNavigation(initSelectedIndex: 2),
    );
  }
}
