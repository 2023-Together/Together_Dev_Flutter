import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/customer_service/notice/notice_detail_screen.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({
    super.key,
    required this.isLogined,
  });

  final bool isLogined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드를 열었을때 사이즈가 조정되는 현상을 해결
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = noticeList[index];
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.2,
                ),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  onTap: () {
                    context.pushNamed(
                      NoticeDetailScreen.routeName,
                      extra: NoticeDetailScreenArgs(
                        noticeId: item["id"],
                        noticeTitle: item["title"],
                        noticeContent: item["content"],
                        noticeDate: item["date"],
                        noticeImage: ["assets/images/70836_50981_2758.jpg"],
                        isLogined: isLogined,
                      ),
                    );
                  },
                  title: Text(item["title"]),
                  titleTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  subtitle: Text(item["date"]),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                  ),
                ),
              ],
            ),
          );
        },
        // separatorBuilder: (context, index) => const Divider(thickness: 2),
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
