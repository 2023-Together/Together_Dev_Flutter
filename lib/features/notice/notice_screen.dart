import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/notice/widgets/notice_card.dart';
import 'package:swag_cross_app/features/notice/notice_edit_screen.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';

class NoticeScreen extends StatelessWidget {
  static const routeName = "main_notice";
  static const routeURL = "/main_notice";

  const NoticeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    return Scaffold(
      // 키보드를 열었을때 사이즈가 조정되는 현상을 해결
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("공지사항"),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: isLogined ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          heroTag: "community_edit",
          onPressed: () {
            // 동아리 게시글 작성
            context.pushNamed(NoticeEditScreen.routeName);
          },
          backgroundColor: Colors.blue.shade300,
          child: const FaIcon(
            FontAwesomeIcons.penToSquare,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        itemBuilder: (context, index) {
          final item = noticeList[index];
          return NoticeCard(
            id: item["id"],
            title: item["title"],
            content: item["content"],
            date: item["date"],
            images: const ["assets/images/70836_50981_2758.jpg"],
            isLogined: isLogined,
          );
        },
        separatorBuilder: (context, index) => Gaps.v6,
        itemCount: noticeList.length,
      ),
    );
  }
}

List<Map<String, dynamic>> noticeList = [
  {
    "id": 1,
    "title": "제목1",
    "content": "내용1",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 2,
    "title": "제목2",
    "content": "내용2",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 3,
    "title": "제목3",
    "content": "내용3",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 4,
    "title": "제목4",
    "content": "내용4",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 5,
    "title": "제목5",
    "content": "내용5",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 6,
    "title": "제목6",
    "content": "내용6",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 7,
    "title": "제목7",
    "content": "내용7",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 8,
    "title": "제목8",
    "content": "내용8",
    "date": "2023-07-10 16:43",
  },
];
