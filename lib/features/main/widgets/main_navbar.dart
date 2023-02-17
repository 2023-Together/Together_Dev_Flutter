import 'package:flutter/material.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({
    super.key,
  });

  @override
  State<MainNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 92, 27, 243),
      unselectedItemColor: Colors.black,
      selectedFontSize: 16,
      unselectedFontSize: 16,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _currentIndex,
      onTap: _onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: '단톡방'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined), label: '내 일정'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_outlined), label: '팀원모집'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: '내정보'),
      ],
    );
  }
}
