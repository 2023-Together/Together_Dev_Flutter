import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/customer_service/qna/qna_detail_screen.dart';
import 'package:swag_cross_app/features/customer_service/qna/qna_edit_screen.dart';

class QnAScreen extends StatelessWidget {
  const QnAScreen({
    super.key,
    required this.isFocused,
    required this.isLogined,
  });

  final bool isFocused;
  final bool isLogined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드를 열었을때 사이즈가 조정되는 현상을 해결
      resizeToAvoidBottomInset: false,
      floatingActionButton: isLogined && !isFocused
          ? FloatingActionButton(
              heroTag: "community_edit",
              onPressed: () {
                // 동아리 게시글 작성
                context.pushNamed(QnAEditScreen.routeName);
              },
              backgroundColor: Colors.blue.shade300,
              child: const FaIcon(
                FontAwesomeIcons.penToSquare,
                color: Colors.black,
              ),
            )
          : null,
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = qnaList[index];
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    context.pushNamed(
                      QnADetailScreen.routeName,
                      extra: QnADetailScreenArgs(
                        qnaId: index + 1,
                        qnaUser: item["user"],
                        qnaContent: item["content"],
                        qnaDate: item["date"],
                        isLogined: isLogined,
                        answerText: "답변입니다!",
                      ),
                    );
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  leading: const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/77985708?v=4",
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    item["user"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  titleTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  subtitle: Text(
                    item["date"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: index % 2 == 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 6,
                          ),
                          color: Colors.purple.shade300,
                          child: const Text(
                            "답변 완료",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 6,
                          ),
                          color: Colors.grey.shade600,
                          child: const Text(
                            "답변 미완료",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 16, right: 16),
                  child: Text(
                    item["content"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        // separatorBuilder: (context, index) => const Divider(thickness: 2),
        itemCount: qnaList.length,
      ),
    );
  }
}

List<Map<String, dynamic>> qnaList = [
  {
    "user": "유저1",
    "content": "앱이 제대로 실행되지 않는 오류가 발생했습니다. 이오류를 해결하려면 어떻게 해야하나요?",
    "date": "2023-07-10 16:43",
  },
  {
    "user": "유저2",
    "content": "내용2",
    "date": "2023-07-10 16:43",
  },
  {
    "user": "유저3",
    "content": "내용3",
    "date": "2023-07-10 16:43",
  },
  {
    "user": "유저4",
    "content": "내용4",
    "date": "2023-07-10 16:43",
  },
  {
    "user": "유저5",
    "content": "내용5",
    "date": "2023-07-10 16:43",
  },
  {
    "user": "유저6",
    "content": "내용6",
    "date": "2023-07-10 16:43",
  },
  {
    "user": "유저7",
    "content": "내용7",
    "date": "2023-07-10 16:43",
  },
  {
    "user": "유저8",
    "content": "내용8",
    "date": "2023-07-10 16:43",
  },
];
