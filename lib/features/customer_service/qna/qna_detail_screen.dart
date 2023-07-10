import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';

class QnADetailScreenArgs {
  final int qnaId;
  final String qnaUser;
  final String qnaContent;
  final String qnaDate;
  final bool isLogined;
  final String answerText;

  const QnADetailScreenArgs({
    required this.qnaId,
    required this.qnaUser,
    required this.qnaContent,
    required this.qnaDate,
    required this.isLogined,
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
    required this.isLogined,
    required this.answerText,
  });

  final int qnaId;
  final String qnaUser;
  final String qnaContent;
  final String qnaDate;
  final bool isLogined;
  final String answerText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.25,
        actions: [
          if (isLogined)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.purple.shade300,
                  ),
                ),
                onPressed: () {},
                child: const Text("수정"),
              ),
            ),
        ],
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
                    child: Text(
                      answerText,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
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
