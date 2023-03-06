import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/chatting/chatting_screen.dart';
import 'package:swag_cross_app/features/searchPage/search_vol_screen.dart';
import 'package:swag_cross_app/features/mainNavigation/widgets/nav_tab.dart';
import 'package:swag_cross_app/features/myCalendar/my_calendar_screen.dart';
import 'package:swag_cross_app/features/team/team_screen.dart';
import 'package:swag_cross_app/features/userProfile/user_profile_screen.dart';

class MainNavigation extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initSelectedIndex;
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            child: const MyCalendarScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const ChattingScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const TeamScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size10),
          child: Row(
            children: [
              NavTab(
                text: "봉사검색",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "내일정",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.calendar,
                selectedIcon: FontAwesomeIcons.solidCalendar,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "톡방",
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.comment,
                selectedIcon: FontAwesomeIcons.solidComment,
                onTap: () => _onTap(2),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "팀원모집",
                isSelected: _selectedIndex == 3,
                icon: Icons.people_outlined,
                selectedIcon: Icons.people_rounded,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "프로필",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.circleUser,
                selectedIcon: FontAwesomeIcons.solidCircleUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
