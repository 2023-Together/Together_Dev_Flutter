import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/club/club_main_screen.dart';
import 'package:swag_cross_app/features/community/main/main_community_screen.dart';
import 'package:swag_cross_app/features/main_navigation/widgets/nav_tab.dart';
import 'package:swag_cross_app/features/page_test/vol_search_test_screen.dart';
import 'package:swag_cross_app/features/page_test/uesr_profile_test_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';

class MainNavigationArgs {
  final int initSelectedIndex;

  MainNavigationArgs({
    this.initSelectedIndex = 0,
  });
}

class MainNavigation extends StatefulWidget {
  static const routeName = "main";
  static const routeURL = "/main";
  const MainNavigation({
    super.key,
    this.initSelectedIndex = 0,
  });

  final int initSelectedIndex;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initSelectedIndex;

    // _checkAutoLogined();
  }

  // void _checkAutoLogined() async {
  //   final String? loginData = await LoginStorage.getLoginData();
  //   print(loginData);

  //   if (loginData == null) return;
  //   if (loginData.trim().isNotEmpty) {
  //     List<String> userData = loginData.split(",");

  //     final id = userData[0];
  //     final pw = userData[1];

  //     if (!mounted) return;
  //     context.read<UserProvider>().login("naver");

  //     context.goNamed(MainNavigation.routeName);
  //   }
  // }

  void _onTap(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else if ((index == 2 || index == 3) &&
        !context.read<UserProvider>().isLogined) {
      // LoginStorage.loginCheckIsNone(context, mounted);
      final loginType = context.read<UserProvider>().isLogined;

      if (loginType.toString() != "naver" && loginType.toString() != "kakao") {
        swagPlatformDialog(
          context: context,
          title: "로그인 알림",
          message: "로그인을 해야만 사용할 수 있는 기능입니다! 로그인 창으로 이동하시겠습니까?",
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("아니오"),
            ),
            TextButton(
              onPressed: () => context.goNamed(SignInScreen.routeName),
              child: const Text("예"),
            ),
          ],
        );
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
          Offstage(
            offstage: _selectedIndex != 0,
            child: const MainCommunityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            //child: const SearchVolScreen(),
            child: const VolSearchTestScreen(),
          ),
          // Offstage(
          //   offstage: _selectedIndex != 1,
          //   child: const OrgSearchTestScreen(),
          // ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const ClubMainScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            //child: const UserProfileScreen(),
            child: UserProfileTestScreen(),
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
                text: "홈",
                isSelected: _selectedIndex == 0,
                unSelectedIcon: Icons.home_outlined,
                selectedIcon: Icons.home,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
                imgURI: "",
                isLogined: isLogined,
              ),
              NavTab(
                text: "봉사",
                isSelected: _selectedIndex == 1,
                unSelectedIcon: Icons.manage_search_outlined,
                selectedIcon: Icons.manage_search,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
                imgURI: "",
                isLogined: isLogined,
              ),
              // NavTab(
              //   text: "기관",
              //   isSelected: _selectedIndex == 1,
              //   unSelectedIcon: Icons.content_paste_search,
              //   selectedIcon: Icons.content_paste_search_outlined,
              //   onTap: () => _onTap(1),
              //   selectedIndex: _selectedIndex,
              //   imgURI: "",
              //   isLogined: isLogined,
              // ),
              NavTab(
                text: "동아리",
                isSelected: _selectedIndex == 2,
                unSelectedIcon: Icons.groups_2_outlined,
                selectedIcon: Icons.groups_2,
                onTap: () => _onTap(2),
                selectedIndex: _selectedIndex,
                imgURI: "",
                isLogined: isLogined,
              ),
              NavTab(
                text: "프로필",
                isSelected: _selectedIndex == 3,
                unSelectedIcon: FontAwesomeIcons.circleUser,
                selectedIcon: FontAwesomeIcons.solidCircleUser,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
                imgURI: "https://avatars.githubusercontent.com/u/77985708?v=4",
                isLogined: isLogined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
