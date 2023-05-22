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
    return Scaffold(
      appBar: AppBar(
        title: const Text("공지사항"),
      ),
      body: Container(),
    );
  }
}
