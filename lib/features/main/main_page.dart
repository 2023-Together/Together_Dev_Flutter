// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main/searchPage/search_vol_list.dart';
import 'package:swag_cross_app/features/main/widgets/main_button.dart';
import 'package:swag_cross_app/features/main/widgets/main_navbar.dart';
import 'package:swag_cross_app/features/storages/secure_storage_login.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    SecureStorageLogin.loginCheckIsNone(context, mounted);
  }

  // 봉사 찾기 누르면 작동
  void _onVolSearchTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchVolList(),
      ),
    );
  }

  // 공지사항 누르면 작동
  void _onCommunityTap() async {}

  // 로그인 테스트1
  void _onTest1Tap() async {
    print(await SecureStorageLogin.getLoginType());
  }

  // 로그인 테스트2
  void _onTest2Tap() async {
    print(await SecureStorageLogin.getLoginType());
    SecureStorageLogin.saveLoginType("none");
    print(await SecureStorageLogin.getLoginType());
    SecureStorageLogin.loginCheckIsNone(context, mounted);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 176, 214, 232),
        title: const Text("메인"),
      ),
      bottomNavigationBar: const MainNavbar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size20,
            horizontal: Sizes.size32,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      "배너",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ),
                ),
                Gaps.v16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _onVolSearchTap,
                      child: const MainButton(text: "봉사 찾기"),
                    ),
                    GestureDetector(
                      onTap: _onCommunityTap,
                      child: const MainButton(text: "공지사항"),
                    ),
                  ],
                ),
                Gaps.v20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _onTest1Tap,
                      child: const MainButton(text: "로그인 테스트1"),
                    ),
                    GestureDetector(
                      onTap: _onTest2Tap,
                      child: const MainButton(text: "로그인 테스트2"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
