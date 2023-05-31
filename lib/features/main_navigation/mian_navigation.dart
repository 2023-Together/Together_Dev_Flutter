import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/comunity/comunity_screen.dart';
import 'package:swag_cross_app/features/page_test/club_search_test_screen.dart';
import 'package:swag_cross_app/features/main_navigation/widgets/nav_tab.dart';
import 'package:swag_cross_app/features/page_test/org_search_test_screen.dart';
import 'package:swag_cross_app/features/page_test/vol_search_test_screen.dart';
import 'package:swag_cross_app/features/page_test/uesr_profile_test_screen.dart';
import 'package:swag_cross_app/storages/secure_storage_login.dart';

class MainNavigationArgs {
  final int initSelectedIndex;

  MainNavigationArgs({required this.initSelectedIndex});
}

class MainNavigation extends StatefulWidget {
  static const routeName = "main";
  static const routeURL = "/";
  const MainNavigation({
    super.key,
    required this.initSelectedIndex,
  });

  final int initSelectedIndex;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;
  bool _isLogined = false;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initSelectedIndex;

    checkLoginType();
  }

  void _onTap(int index) {
    if (index == 2) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 4 && !_isLogined) {
      SecureStorageLogin.loginCheckIsNone(context, mounted);
    } else {
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
            Offstage(
              offstage: _selectedIndex != 0,
              //child: const SearchVolScreen(),
              child: const VolSearchTestScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 1,
              child: const OrgSearchTestScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 2,
              child: const ComunityScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClubSearchTestScreen(
                  image: Image.asset(
                    'assets/images/club1.jpg',
                    fit: BoxFit.cover,
                  ),
                  club_name: "동아리 1",
                  club_def: "동아리1에서 부원을 모집합니다. 많은 관심 부탁드립니다 :)",
                ),
              ),
            ),
            Offstage(
              offstage: _selectedIndex != 4,
              //child: const UserProfileScreen(),
              child: const UserProfileTestScreen(),
              //child: const UserProfileTestScreen(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                  text: "봉사",
                  isSelected: _selectedIndex == 0,
                  unSelectedIcon: Icons.manage_search_outlined,
                  selectedIcon: Icons.manage_search,
                  onTap: () => _onTap(0),
                  selectedIndex: _selectedIndex,
                  imgURI: "",
                  logined: _isLogined,
                ),
                NavTab(
                  text: "기관",
                  isSelected: _selectedIndex == 1,
                  unSelectedIcon: Icons.content_paste_search,
                  selectedIcon: Icons.content_paste_search_outlined,
                  onTap: () => _onTap(1),
                  selectedIndex: _selectedIndex,
                  imgURI: "",
                  logined: _isLogined,
                ),
                // 홈버튼 애니메이션 버전
                // GestureDetector(
                //   onTap: () => _onTap(2),
                //   child: AnimatedOpacity(
                //     opacity: _selectedIndex == 2 ? 1 : 0.6,
                //     duration: const Duration(milliseconds: 300),
                //     child: Container(
                //       height: 60,
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: Sizes.size6,
                //       ),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(Sizes.size80),
                //         color: Colors.grey.shade100,
                //       ),
                //       child: Center(
                //         child: Icon(
                //           _selectedIndex == 2 ? Icons.home : Icons.home_outlined,
                //           size: 50,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                NavTab(
                  text: "홈",
                  isSelected: _selectedIndex == 2,
                  unSelectedIcon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  onTap: () => _onTap(2),
                  selectedIndex: _selectedIndex,
                  imgURI: "",
                  logined: _isLogined,
                ),
                NavTab(
                  text: "동아리",
                  isSelected: _selectedIndex == 3,
                  unSelectedIcon: Icons.groups_2_outlined,
                  selectedIcon: Icons.groups_2,
                  onTap: () => _onTap(3),
                  selectedIndex: _selectedIndex,
                  imgURI: "",
                  logined: _isLogined,
                ),
                NavTab(
                  text: "프로필",
                  isSelected: _selectedIndex == 4,
                  unSelectedIcon: FontAwesomeIcons.circleUser,
                  selectedIcon: FontAwesomeIcons.solidCircleUser,
                  onTap: () => _onTap(4),
                  selectedIndex: _selectedIndex,
                  imgURI:
                      "https://avatars.githubusercontent.com/u/77985708?v=4",
                  logined: _isLogined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
