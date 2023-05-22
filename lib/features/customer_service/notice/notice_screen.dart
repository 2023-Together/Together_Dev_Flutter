import 'package:flutter/material.dart';

class NoticeScreen extends StatefulWidget {
  static const routeName = "notice";
  static const routeURL = "/notice";
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // 키보드를 열었을때 사이즈가 조정되는 현상을 해결
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text("공지사항"),
      ),
    );
  }
}
