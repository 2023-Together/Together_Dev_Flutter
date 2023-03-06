// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/mainNavigation/mian_navigation.dart';
import 'package:swag_cross_app/features/main/widgets/main_button.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_main.dart';
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

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // 변수를 만들때 바로 초기화 해주어도 되지만 무조건 late를 붙여야 작동된다.
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<Offset> _alertAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  bool _isLogined = false;
  bool _showAlert = false;

  @override
  void initState() {
    super.initState();

    var loginType = SecureStorageLogin.getLoginType();
    if (loginType != "none" || loginType != null) {
      _isLogined = true;
    }
  }

  void _toggleAnimations() async {
    // 이미 애니메이션이 실행되었다면
    if (_animationController.isCompleted) {
      // 애니메이션을 원래상태로 되돌림
      // 슬라이드가 다올라갈때까지 배리어를 없애면 안됨
      await _animationController.reverse();
      _showAlert = false;
    } else {
      // 애니메이션을 실행
      _animationController.forward();
      _showAlert = true;
    }
    setState(() {});
  }

  // 봉사 찾기 누르면 작동
  void _onVolSearchTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initSelectedIndex: 0),
      ),
    );
  }

  // 공지사항 누르면 작동
  void _onCommunityTap() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initSelectedIndex: 2),
      ),
    );
  }

  // 로그인 테스트1
  void _onTest1Tap() async {
    print(await SecureStorageLogin.getLoginType());
    _isLogined = true;
    setState(() {});
  }

  // 로그인 테스트2
  void _onTest2Tap() async {
    print(await SecureStorageLogin.getLoginType());
    SecureStorageLogin.saveLoginType("none");
    print(await SecureStorageLogin.getLoginType());
    _isLogined = false;
    setState(() {});
    // SecureStorageLogin.loginCheckIsNone(context, mounted);
  }

  // 로그인 상태가 아닐때 아이콘 클릭 하면 실행
  void onLoginTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignInMain(),
      ),
    );
  }

  // 로그인 상태일때 아이콘 클릭 하면 실행
  void onProfileTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initSelectedIndex: 4),
      ),
    );
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
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size16,
                horizontal: Sizes.size32,
              ),
              child: Center(
                child: Column(
                  children: [
                    _isLogined
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: _toggleAnimations,
                                child: const FaIcon(
                                  FontAwesomeIcons.bell,
                                  size: 40,
                                  color: Colors.black54,
                                ),
                              ),
                              Gaps.h10,
                              GestureDetector(
                                onTap: onProfileTap,
                                child: const CircleAvatar(
                                  radius: Sizes.size20,
                                  foregroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/77985708?v=4",
                                  ),
                                  child: Text("재현"),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: onLoginTap,
                                child: const FaIcon(
                                  FontAwesomeIcons.circleUser,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                    Gaps.v16,
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "광고 배너",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _onVolSearchTap,
                          child: const MainButton(text: "봉사 찾기"),
                        ),
                        GestureDetector(
                          onTap: _onCommunityTap,
                          child: const MainButton(text: "커뮤니티"),
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
          // 슬라이드 애니메이션 구현
          // 하지만 정상적인 화면도 막기때문에 없애주는 작업 필요
          if (_showAlert)
            // 슬라이드 화면 뒤쪽의 검은 화면 구현
            AnimatedModalBarrier(
              color: _barrierAnimation,
              // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
              dismissible: true,
              // 자신을 클릭하면 실행되는 함수
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _alertAnimation,
            child: SafeArea(
              child: Container(
                height: 500,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size18,
                  horizontal: Sizes.size10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.size8),
                    bottomRight: Radius.circular(Sizes.size8),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "알림창",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Gaps.v18,
                    const Divider(thickness: 1, height: 1, color: Colors.black),
                    Gaps.v10,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Sizes.size14),
                      ),
                      child: const ListTile(
                        title: Text("알림1"),
                        subtitle: Text("내용"),
                      ),
                    ),
                    Gaps.v5,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Sizes.size14),
                      ),
                      child: const ListTile(
                        title: Text("알림1"),
                        subtitle: Text("내용"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
