import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/club/club_main_screen.dart';
import 'package:swag_cross_app/features/community/main/main_community_screen.dart';
import 'package:swag_cross_app/features/main_navigation/widgets/nav_tab.dart';
import 'package:swag_cross_app/features/search_page/view/vol_search_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/user_profile/view/user_profile_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/providers/main_navigation_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

class MainNavigation extends StatefulWidget {
  static const routeName = "main";
  static const routeURL = "/main";
  const MainNavigation({
    super.key,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  @override
  void initState() {
    super.initState();

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
      context.read<MainNavigationProvider>().changeIndex(index);
    } else if ((index == 2 || index == 3) &&
        !context.read<UserProvider>().isLogined) {
      final isLogined = context.read<UserProvider>().isLogined;

      if (!isLogined) {
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
              onPressed: () {
                context.pop();
                context.pushNamed(SignInScreen.routeName);
              },
              child: const Text("예"),
            ),
          ],
        );
      }
    } else {
      context.read<MainNavigationProvider>().changeIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    final selectedIndex =
        context.watch<MainNavigationProvider>().navigationIndex;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
          Offstage(
            offstage: selectedIndex != 0,
            child: const MainCommunityScreen(),
          ),
          Offstage(
            offstage: selectedIndex != 1,
            //child: const SearchVolScreen(),
            child: const VolSearchScreen(),
          ),
          // Offstage(
          //   offstage: selectedIndex != 1,
          //   child: const OrgSearchScreen(),
          // ),
          Offstage(
            offstage: selectedIndex != 2,
            child: isLogined ? const ClubMainScreen() : null,
          ),
          Offstage(
            offstage: selectedIndex != 3,
            child: isLogined ? const UserProfileScreen() : null,
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
                isSelected: selectedIndex == 0,
                unSelectedIcon: Icons.home_outlined,
                selectedIcon: Icons.home,
                onTap: () => _onTap(0),
                selectedIndex: selectedIndex,
                isLogined: isLogined,
              ),
              NavTab(
                text: "봉사",
                isSelected: selectedIndex == 1,
                unSelectedIcon: Icons.manage_search_outlined,
                selectedIcon: Icons.manage_search,
                onTap: () => _onTap(1),
                selectedIndex: selectedIndex,
                isLogined: isLogined,
              ),
              // NavTab(
              //   text: "기관",
              //   isSelected: selectedIndex == 1,
              //   unSelectedIcon: Icons.content_paste_search,
              //   selectedIcon: Icons.content_paste_search_outlined,
              //   onTap: () => _onTap(1),
              //   selectedIndex: _selectedIndex,
              //   imgURI: "",
              //   isLogined: isLogined,
              // ),
              NavTab(
                text: "동아리",
                isSelected: selectedIndex == 2,
                unSelectedIcon: Icons.groups_2_outlined,
                selectedIcon: Icons.groups_2,
                onTap: () => _onTap(2),
                selectedIndex: selectedIndex,
                isLogined: isLogined,
              ),
              NavTab(
                text: isLogined ? "프로필" : "로그인",
                isSelected: selectedIndex == 3,
                unSelectedIcon: isLogined
                    ? Icons.account_circle_outlined
                    : Icons.no_accounts_outlined,
                selectedIcon: Icons.account_circle,
                onTap: () => _onTap(3),
                selectedIndex: selectedIndex,
                isLogined: isLogined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}