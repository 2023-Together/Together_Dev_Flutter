import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';

List<Map<String, dynamic>> noticeList = [
  {
    "title": "제목1",
    "content": "내용1",
  },
  {
    "title": "제목2",
    "content": "내용2",
  },
  {
    "title": "제목3",
    "content": "내용3",
  },
  {
    "title": "제목4",
    "content": "내용4",
  },
  {
    "title": "제목5",
    "content": "내용5",
  },
  {
    "title": "제목6",
    "content": "내용6",
  },
  {
    "title": "제목7",
    "content": "내용7",
  },
  {
    "title": "제목8",
    "content": "내용8",
  },
];

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
      // 키보드를 열었을때 사이즈가 조정되는 현상을 해결
      resizeToAvoidBottomInset: false,
      body: ListView.separated(
        itemBuilder: (context, index) {
          final item = noticeList[index];
          return ListTile(
            title: Text(item["title"]),
            subtitle: Text(item["content"]),
          );
        },
        separatorBuilder: (context, index) => Gaps.v5,
        itemCount: noticeList.length,
      ),
    );
  }
}
