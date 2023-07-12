import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';

class QnADetailScreenArgs {
  final int qnaId;
  final String qnaUser;
  final String qnaContent;
  final String qnaDate;
  final String answerText;

  const QnADetailScreenArgs({
    required this.qnaId,
    required this.qnaUser,
    required this.qnaContent,
    required this.qnaDate,
    required this.answerText,
  });
}

class QnADetailScreen extends StatelessWidget {
  static const routeName = "qna_detail";
  static const routeURL = "qna_detail";

  const QnADetailScreen({
    super.key,
    required this.qnaId,
    required this.qnaUser,
    required this.qnaContent,
    required this.qnaDate,
    required this.answerText,
  });

  final int qnaId;
  final String qnaUser;
  final String qnaContent;
  final String qnaDate;
  final String answerText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.25,
        title: const Text("Q&A"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v10,
            Text(
              qnaUser,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            Gaps.v10,
            Text(
              qnaDate,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
            ),
            Gaps.v10,
            // const Divider(
            //   thickness: 1,
            //   color: Colors.black,
            // ),
            Gaps.v10,
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 100, // 최소 높이
              ),
              child: Text(
                qnaContent,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("수정"),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("삭제"),
                ),
              ],
            ),
            Gaps.v10,
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Gaps.v10,
            qnaId % 2 == 1
                ? Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      minHeight: 100, // 최소 높이
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ListTile(
                          title: Text(
                            "관리자",
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            "1시간전",
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(answerText),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      "답변이 존재하지 않습니다!",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
