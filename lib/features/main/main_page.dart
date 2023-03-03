// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main/searchPage/search_vol_list.dart';
import 'package:swag_cross_app/features/main/widgets/main_button.dart';
import 'package:swag_cross_app/features/main/widgets/main_navbar.dart';
import 'package:swag_cross_app/features/storages/secure_storage_login.dart';

import '../schedule/screen.dart';

class MainPage extends StatefulWidget {
  final int HOME_PAGE = 0;
  final int CHAT_PAGE = 1;
  final int SCHEDULE_PAGE = 2;
  final int TEAM_PAGE = 3;
  final int MY_PAGE = 4;

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentPage;
  @override
  void initState() {
    super.initState();
    _currentPage = widget.HOME_PAGE;
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

  void _onTap(int index) {
    setState(() {
      switch (index) {
        case 0:
          _currentPage = widget.HOME_PAGE;
          break;
        case 1:
          _currentPage = widget.CHAT_PAGE;
          break;
        case 2:
          _currentPage = widget.SCHEDULE_PAGE;
          break;
        case 3:
          _currentPage = widget.TEAM_PAGE;
          break;
        case 4:
          _currentPage = widget.MY_PAGE;
          break;
      }
    });
    print(_currentPage);
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 92, 27, 243),
      unselectedItemColor: Colors.black,
      selectedFontSize: 16,
      unselectedFontSize: 16,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _currentPage,
      onTap: _onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: '단톡방'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: '내 일정',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_outlined), label: '팀원모집'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: '내정보',
        ),
      ],
    );
  }

  Widget _body() {
    switch (_currentPage) {
      case 0:
        return SafeArea(
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
        );
      case 1:
        return Container();
      case 2:
        return const TableCalendarPage();
      case 3:
        return Container();
      case 4:
        return Container();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 176, 214, 232),
        title: const Text("메인"),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }
}
