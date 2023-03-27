import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/club/club_screen.dart';
import 'package:swag_cross_app/features/chatting/chatting_screen.dart';
import 'package:swag_cross_app/features/comunity/comunity_screen.dart';
import 'package:swag_cross_app/features/search_page/view/search_vol_screen.dart';
import 'package:swag_cross_app/features/main_navigation/widgets/nav_tab.dart';
import 'package:swag_cross_app/features/storages/secure_storage_login.dart';
import 'package:swag_cross_app/features/user_profile/view/user_profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({
    super.key,
    required this.initSelectedIndex,
  });

  final int initSelectedIndex;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  late final Animation<double> _scaleAnimation = Tween(
    begin: 1.0,
    end: 1.2,
  ).animate(_animationController);

  late final Animation<double> _opacityAnimation = Tween(
    begin: 0.6,
    end: 1.0,
  ).animate(_animationController);

  late final Animation<Offset> _upDownAnimation = Tween(
    begin: Offset.zero,
    end: const Offset(0, -0.3),
  ).animate(_animationController);

  late int _selectedIndex;
  bool _isLogined = false;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initSelectedIndex;

    if (_selectedIndex == 2) {
      _animationController.forward();
    }

    checkLoginType();
  }

  void _onTap(int index) {
    if (index == 2) {
      _animationController.forward();
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 4 && !_isLogined) {
      SecureStorageLogin.loginCheckIsNone(context, mounted);
    } else {
      _animationController.reverse();
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // 로그인 타입을 가져와서 로그인 상태를 적용하는 함수
  void checkLoginType() async {
    var loginType = await SecureStorageLogin.getLoginType();
    print(loginType);
    if (loginType == "naver" || loginType == "kakao") {
      _isLogined = true;
    } else {
      _isLogined = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
          Offstage(
            offstage: _selectedIndex != 0,
            child: const SearchVolScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const ChattingScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const ComunityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ClubScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size5,
          vertical: Sizes.size6,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "봉사검색",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
                imgURI: "",
                logined: _isLogined,
              ),
              NavTab(
                text: "채팅방",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.comment,
                selectedIcon: FontAwesomeIcons.solidComment,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
                imgURI: "",
                logined: _isLogined,
              ),
              // 홈버튼
              GestureDetector(
                onTap: () => _onTap(2),
                child: AnimatedOpacity(
                  opacity: _selectedIndex == 2 ? 1 : 0.6,
                  duration: const Duration(milliseconds: 150),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _upDownAnimation,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size80),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(
                            child: Icon(
                              _selectedIndex == 2
                                  ? Icons.home
                                  : Icons.home_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              NavTab(
                text: "동아리",
                isSelected: _selectedIndex == 3,
                icon: Icons.people_outlined,
                selectedIcon: Icons.people_rounded,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
                imgURI: "",
                logined: _isLogined,
              ),
              NavTab(
                text: "프로필",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.circleUser,
                selectedIcon: FontAwesomeIcons.solidCircleUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
                imgURI: "https://avatars.githubusercontent.com/u/77985708?v=4",
                logined: _isLogined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}